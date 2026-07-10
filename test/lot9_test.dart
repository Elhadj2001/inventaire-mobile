import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/data/database.dart';

ScansLocauxCompanion _scan(String id, {bool manuelle = false}) => ScansLocauxCompanion.insert(
      id: id,
      campagneId: 'c1',
      numeroInventaire: '10001',
      pieceId: 'p1',
      serviceId: const Value('s1'),
      etat: 'bon',
      scanneLe: DateTime(2026, 7, 9, 10),
      creeLe: DateTime.now(),
      saisieManuelle: Value(manuelle),
    );

void main() {
  test('suggestions de biens (saisie manuelle)', () async {
    final db = openInMemory();
    await db.appliquerReferentiel({
      'biens': [
        {'id': 'b1', 'numero_inventaire': '20437', 'designation': 'CAISSON ROULANT', 'statut': 'actif'},
        {'id': 'b2', 'numero_inventaire': '20438', 'designation': 'BUREAU', 'statut': 'actif'},
        {'id': 'b3', 'numero_inventaire': '99999', 'designation': 'ETUVE', 'statut': 'actif'},
      ],
    });
    final parNumero = await db.chercherBiens('2043');
    expect(parNumero.map((b) => b.numeroInventaire).toSet(), {'20437', '20438'});
    final parLibelle = await db.chercherBiens('caisson');
    expect(parLibelle.single.numeroInventaire, '20437');
    await db.close();
  });

  test('le flag saisie_manuelle est stocké et remonté dans le payload', () async {
    final db = openInMemory();
    await db.enfilerScan(_scan('id-1', manuelle: true));
    final scans = await db.scansParStatut('en_attente');
    expect(scans.single.saisieManuelle, isTrue);
    await db.close();
  });

  test('feuille de route : application + lecture depuis le cache', () async {
    final db = openInMemory();
    await db.appliquerAffectations('c1', [
      {
        'id': 'a1', 'type': 'piece', 'lieu_id': 'l1', 'lieu_nom': 'CAMPUS',
        'piece_id': 'p1', 'piece_code': 'DK01-B01-E01-035', 'piece_libelle': 'HALL',
        'service_id': 's1', 'pieces_affectees': 1, 'pieces_scannees': 0, 'nb_scans': 0,
      },
      {
        'id': 'a2', 'type': 'lieu', 'lieu_id': 'l2', 'lieu_nom': 'ZOLA',
        'piece_id': null, 'piece_code': null, 'piece_libelle': null, 'service_id': null,
        'pieces_affectees': 12, 'pieces_scannees': 3, 'nb_scans': 5,
      },
    ]);
    final affs = await db.mesAffectations('c1');
    expect(affs.length, 2);
    final piece = affs.firstWhere((a) => a.type == 'piece');
    expect(piece.pieceCode, 'DK01-B01-E01-035');
    expect(piece.serviceId, 's1');

    // une nouvelle application remplace (delta complet)
    await db.appliquerAffectations('c1', []);
    expect(await db.mesAffectations('c1'), isEmpty);
    await db.close();
  });

  test('scans du jour : compte les scans locaux du jour', () async {
    final db = openInMemory();
    await db.enfilerScan(_scan('id-1'));
    await db.enfilerScan(_scan('id-2'));
    final debut = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final aujourdhui = await db.scansDuJour(debut);
    expect(aujourdhui.length, 2);
    await db.close();
  });
}
