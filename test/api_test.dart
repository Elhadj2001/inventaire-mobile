import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/models/refs.dart';
import 'package:inventaire_mobile/services/api.dart';

/// Adaptateur dio factice : renvoie des réponses canned selon méthode + chemin.
class _FakeAdapter implements HttpClientAdapter {
  final List<({String method, String prefix, int status, Object body})> routes;
  _FakeAdapter(this.routes);

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    for (final r in routes) {
      if (r.method == options.method && options.path.startsWith(r.prefix)) {
        return ResponseBody.fromString(
          jsonEncode(r.body),
          r.status,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        );
      }
    }
    return ResponseBody.fromString('{"detail":"not found"}', 404, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });
  }

  @override
  void close({bool force = false}) {}
}

ApiService _api(List<({String method, String prefix, int status, Object body})> routes) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test'))..httpClientAdapter = _FakeAdapter(routes);
  return ApiService(dio);
}

void main() {
  test('campagneOuverte : 200 -> Campagne', () async {
    final api = _api([
      (
        method: 'GET',
        prefix: '/campagnes/ouverte',
        status: 200,
        body: {'id': 'c1', 'nom': 'Inv 2026', 'date_debut': '2026-07-08', 'date_fin': null, 'statut': 'ouverte', 'perimetre_lieu_id': null},
      ),
    ]);
    final c = await api.campagneOuverte();
    expect(c, isNotNull);
    expect(c!.nom, 'Inv 2026');
  });

  test('campagneOuverte : 404 -> null', () async {
    final api = _api([(method: 'GET', prefix: '/campagnes/ouverte', status: 404, body: {'detail': 'x'})]);
    expect(await api.campagneOuverte(), isNull);
  });

  test('lieux : parse la liste', () async {
    final api = _api([
      (
        method: 'GET',
        prefix: '/lieux',
        status: 200,
        body: [
          {'id': 'l1', 'code': 'DK01', 'nom': 'CAMPUS'},
          {'id': 'l2', 'code': 'DK02', 'nom': 'ZOLA'},
        ],
      ),
    ]);
    final lieux = await api.lieux();
    expect(lieux.length, 2);
    expect(lieux.first.nom, 'CAMPUS');
  });

  test('creerService : renvoie le service (get-or-create)', () async {
    final api = _api([
      (
        method: 'POST',
        prefix: '/services',
        status: 201,
        body: {'id': 's1', 'nom': 'Labo A', 'lieu_id': 'l1', 'actif': true},
      ),
    ]);
    final s = await api.creerService('l1', 'Labo A');
    expect(s.id, 's1');
    expect(s.nom, 'Labo A');
  });

  test('bienParNumero : trouvé / inconnu', () async {
    final trouve = _api([
      (
        method: 'GET',
        prefix: '/biens/par-numero/',
        status: 200,
        body: {'id': 'b1', 'numero_inventaire': '10001', 'designation': 'TERRAIN', 'statut': 'actif', 'etat': null, 'source': 'import_excel', 'photo_url': null, 'piece_id': null, 'piece': null},
      ),
    ]);
    expect(await trouve.bienParNumero('10001'), isA<BienTrouve>());

    final inconnu = _api([(method: 'GET', prefix: '/biens/par-numero/', status: 404, body: {'detail': 'x'})]);
    final res = await inconnu.bienParNumero('ZZZ');
    expect(res, isA<BienInconnu>());
    expect((res as BienInconnu).numeroScanne, 'ZZZ');
  });

  test('creerLigne : 201 -> créé (pas déjà enregistré)', () async {
    final api = _api([
      (
        method: 'POST',
        prefix: '/lignes-inventaire',
        status: 201,
        body: {'ligne': {'id': 'x1'}, 'bien_cree': false},
      ),
    ]);
    final r = await api.creerLigne(
      id: 'x1', campagneId: 'c1', numeroInventaire: '10001',
      pieceId: 'p1', serviceId: 's1', etat: EtatConstate.bon, scanneLe: DateTime(2026, 7, 8),
    );
    expect(r.dejaEnregistre, isFalse);
    expect(r.bienCree, isFalse);
  });

  test('creerLigne : 200 -> rejeu idempotent', () async {
    final api = _api([
      (
        method: 'POST',
        prefix: '/lignes-inventaire',
        status: 200,
        body: {'ligne': {'id': 'x1'}, 'bien_cree': false},
      ),
    ]);
    final r = await api.creerLigne(
      id: 'x1', campagneId: 'c1', numeroInventaire: '10001',
      pieceId: 'p1', serviceId: 's1', etat: EtatConstate.bon, scanneLe: DateTime(2026, 7, 8),
    );
    expect(r.dejaEnregistre, isTrue);
  });
}
