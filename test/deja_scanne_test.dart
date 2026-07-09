import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/data/database.dart';

ScansLocauxCompanion _scanLocal(String id, String numero, DateTime quand, {String piece = 'p1'}) {
  return ScansLocauxCompanion.insert(
    id: id,
    campagneId: 'c1',
    numeroInventaire: numero,
    pieceId: piece,
    etat: 'bon',
    scanneLe: quand,
    creeLe: quand,
    serviceId: const Value('s1'),
  );
}

void main() {
  test('déjà scanné via résumé serveur (+ isolation campagne)', () async {
    final db = openInMemory();
    await db.appliquerScansResume('c1', [
      {
        'bien_id': 'b1',
        'bien_numero': '10001',
        'scanne_le': '2026-07-09T10:00:00Z',
        'agent_nom': 'Agent X',
        'piece_code': 'DK01-B01-E01-035',
      },
    ]);

    final d = await db.dejaScanne('c1', '10001');
    expect(d, isNotNull);
    expect(d!.par, 'Agent X');
    expect(d.pieceCode, 'DK01-B01-E01-035');

    expect(await db.dejaScanne('c1', '99999'), isNull); // autre bien
    expect(await db.dejaScanne('autre', '10001'), isNull); // autre campagne
    await db.close();
  });

  test('déjà scanné via scan local non synchronisé', () async {
    final db = openInMemory();
    await db.appliquerReferentiel({
      'pieces': [
        {'id': 'p1', 'code': 'DK01-X-001', 'libelle': 'X', 'lieu_id': 'l1', 'service_id': null},
      ],
    });
    await db.enfilerScan(_scanLocal('s1', '10001', DateTime(2026, 7, 9, 10)));

    final d = await db.dejaScanne('c1', '10001');
    expect(d, isNotNull);
    expect(d!.par, 'vous');
    expect(d.pieceCode, 'DK01-X-001');
    await db.close();
  });

  test('le scan le plus récent gagne (local vs serveur)', () async {
    final db = openInMemory();
    await db.appliquerScansResume('c1', [
      {'bien_id': 'b1', 'bien_numero': '10001', 'scanne_le': '2026-07-09T09:00:00Z', 'agent_nom': 'Agent X', 'piece_code': 'A'},
    ]);
    await db.enfilerScan(_scanLocal('s1', '10001', DateTime.utc(2026, 7, 9, 15)));

    final d = await db.dejaScanne('c1', '10001');
    expect(d!.par, 'vous'); // le scan local est plus récent
    await db.close();
  });

  test('pas d\'alerte si jamais scanné', () async {
    final db = openInMemory();
    expect(await db.dejaScanne('c1', '10001'), isNull);
    await db.close();
  });
}
