import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/data/database.dart';
import 'package:inventaire_mobile/data/sync_repository.dart';
import 'package:inventaire_mobile/services/api.dart';

/// Adaptateur dio programmable : lit le corps JSON et délègue à un handler.
class _Adapter implements HttpClientAdapter {
  _Adapter(this.handle);
  final FutureOr<(int, Object)> Function(RequestOptions o, dynamic body) handle;

  @override
  Future<ResponseBody> fetch(
    RequestOptions o,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    dynamic body;
    if (requestStream != null) {
      final chunks = await requestStream.toList();
      final bytes = chunks.expand((e) => e).toList();
      try {
        body = jsonDecode(utf8.decode(bytes));
      } catch (_) {
        body = null;
      }
    }
    final (status, resp) = await handle(o, body);
    return ResponseBody.fromString(
      jsonEncode(resp),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

ApiService _apiAvec(FutureOr<(int, Object)> Function(RequestOptions, dynamic) handle) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test'))..httpClientAdapter = _Adapter(handle);
  return ApiService(dio);
}

ScansLocauxCompanion _scan(String id, {String? serviceId, String? serviceLocalId, String? photo}) {
  return ScansLocauxCompanion.insert(
    id: id,
    campagneId: 'c1',
    numeroInventaire: '10001',
    pieceId: 'p1',
    serviceId: Value(serviceId),
    serviceLocalId: Value(serviceLocalId),
    etat: 'bon',
    photoLocale: Value(photo),
    scanneLe: DateTime(2026, 7, 8, 10),
    creeLe: DateTime(2026, 7, 8, 10),
  );
}

void main() {
  test('application du référentiel : cache peuplé + résolution locale', () async {
    final db = openInMemory();
    await db.appliquerReferentiel({
      'lieux': [
        {'id': 'l1', 'code': 'DK01', 'nom': 'CAMPUS'},
      ],
      'services': [
        {'id': 's1', 'nom': 'Labo A', 'lieu_id': 'l1', 'actif': true},
      ],
      'pieces': [
        {'id': 'p1', 'code': 'DK01-B01-E01-035', 'libelle': 'HALL', 'batiment': 'B01', 'niveau': 'E01', 'lieu_id': 'l1', 'service_id': 's1'},
      ],
      'biens': [
        {'id': 'b1', 'numero_inventaire': '10001', 'designation': 'TERRAIN', 'statut': 'actif'},
      ],
    });
    expect((await db.lieux()).length, 1);
    expect((await db.piecesDuLieu('l1')).length, 1);
    final bien = await db.bienParNumero('10001');
    expect(bien, isNotNull);
    expect(bien!.designation, 'TERRAIN');
    expect(await db.bienParNumero('INCONNU'), isNull); // bien hors cache
    await db.close();
  });

  test('file survit au « kill » (persistance drift sur fichier)', () async {
    final dir = Directory.systemTemp.createTempSync('inv_test');
    final fichier = File('${dir.path}/db.sqlite');
    final db1 = AppDatabase(NativeDatabase(fichier));
    await db1.enfilerScan(_scan('id-1', serviceId: 's1'));
    expect(await db1.compterEnAttente(), 1);
    await db1.close();

    // Réouverture (comme après un redémarrage de l'app)
    final db2 = AppDatabase(NativeDatabase(fichier));
    expect(await db2.compterEnAttente(), 1);
    final scans = await db2.tousLesScans();
    expect(scans.single.id, 'id-1');
    await db2.close();
    dir.deleteSync(recursive: true);
  });

  test('interruption de synchro à mi-lot → reprise sans doublon', () async {
    final db = openInMemory();
    await db.enfilerScan(_scan('id-1', serviceId: 's1'));
    await db.enfilerScan(_scan('id-2', serviceId: 's1'));

    final recus = <String>[];
    var appelSync = 0;
    final api = _apiAvec((o, body) {
      if (o.path == '/sync/lignes-inventaire') {
        appelSync++;
        if (appelSync == 1) {
          throw DioException(requestOptions: o, type: DioExceptionType.connectionError);
        }
        final lignes = (body['lignes'] as List).cast<Map<String, dynamic>>();
        final resultats = lignes.map((l) {
          final id = l['id'] as String;
          final deja = recus.contains(id);
          recus.add(id);
          return {'id': id, 'statut': deja ? 'deja_synchronisee' : 'creee', 'motif': null};
        }).toList();
        return (200, {'resultats': resultats, 'nb_creees': 0, 'nb_deja': 0, 'nb_rejetees': 0});
      }
      return (404, {});
    });
    final repo = SyncRepository(db, api);

    // 1re tentative : échoue (réseau) -> les 2 scans restent en attente
    await expectLater(repo.pousser(), throwsA(isA<DioException>()));
    expect(await db.compterEnAttente(), 2);

    // 2e tentative : réussit -> 0 en attente, chaque id reçu une seule fois
    final res = await repo.pousser();
    expect(res.creees, 2);
    expect(await db.compterEnAttente(), 0);
    expect(recus.toSet().length, 2); // aucun doublon

    // 3e tentative : plus rien à envoyer
    final res3 = await repo.pousser();
    expect(res3.creees, 0);
    await db.close();
  });

  test('remapping service provisoire → id serveur', () async {
    final db = openInMemory();
    await db.creerServiceProvisoire(
      ServicesLocauxCompanion.insert(localId: 'local-1', lieuId: 'l1', nom: 'Recette'),
    );
    await db.enfilerScan(_scan('id-1', serviceLocalId: 'local-1')); // serviceId null au départ

    final api = _apiAvec((o, body) {
      if (o.path == '/services') {
        return (201, {'id': 'srv-1', 'nom': 'Recette', 'lieu_id': 'l1', 'actif': true});
      }
      if (o.path == '/sync/lignes-inventaire') {
        final lignes = (body['lignes'] as List).cast<Map<String, dynamic>>();
        // le service envoyé doit être l'id SERVEUR remappé
        expect(lignes.single['service_id'], 'srv-1');
        return (200, {
          'resultats': [{'id': lignes.single['id'], 'statut': 'creee', 'motif': null}],
          'nb_creees': 1, 'nb_deja': 0, 'nb_rejetees': 0,
        });
      }
      return (404, {});
    });

    final res = await SyncRepository(db, api).pousser();
    expect(res.creees, 1);
    final prov = await db.serviceProvisoire('local-1');
    expect(prov!.serverId, 'srv-1');
    expect(await db.compterEnAttente(), 0);
    await db.close();
  });

  test('bien inconnu du cache : enfilable et synchronisable', () async {
    final db = openInMemory();
    expect(await db.bienParNumero('ZZZ999'), isNull);
    await db.enfilerScan(ScansLocauxCompanion.insert(
      id: 'id-x',
      campagneId: 'c1',
      numeroInventaire: 'ZZZ999',
      pieceId: 'p1',
      serviceId: const Value('s1'),
      etat: 'bon',
      scanneLe: DateTime(2026, 7, 8, 10),
      creeLe: DateTime(2026, 7, 8, 10),
    ));
    expect(await db.compterEnAttente(), 1);

    final api = _apiAvec((o, body) {
      if (o.path == '/sync/lignes-inventaire') {
        final lignes = (body['lignes'] as List).cast<Map<String, dynamic>>();
        expect(lignes.single['numero_inventaire'], 'ZZZ999');
        return (200, {
          'resultats': [{'id': lignes.single['id'], 'statut': 'creee', 'motif': null}],
          'nb_creees': 1, 'nb_deja': 0, 'nb_rejetees': 0,
        });
      }
      return (404, {});
    });
    await SyncRepository(db, api).pousser();
    expect(await db.compterEnAttente(), 0);
    await db.close();
  });

  test('photo Cloudinary non configuré (503) : ligne envoyée sans photo', () async {
    final db = openInMemory();
    final dir = Directory.systemTemp.createTempSync('inv_photo');
    final photo = File('${dir.path}/photo.jpg')..writeAsBytesSync([1, 2, 3]);
    await db.enfilerScan(_scan('id-1', serviceId: 's1', photo: photo.path));

    final api = _apiAvec((o, body) {
      if (o.path == '/photos') return (503, {'detail': 'non configuré'});
      if (o.path == '/sync/lignes-inventaire') {
        final lignes = (body['lignes'] as List).cast<Map<String, dynamic>>();
        expect(lignes.single.containsKey('photo_url'), isFalse); // pas de photo
        return (200, {
          'resultats': [{'id': lignes.single['id'], 'statut': 'creee', 'motif': null}],
          'nb_creees': 1, 'nb_deja': 0, 'nb_rejetees': 0,
        });
      }
      return (404, {});
    });
    final res = await SyncRepository(db, api).pousser();
    expect(res.creees, 1);
    await db.close();
    dir.deleteSync(recursive: true);
  });
}
