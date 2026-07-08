import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/models/refs.dart';
import 'package:inventaire_mobile/state/session.dart';

const _campagne = Campagne(id: 'c1', nom: 'Test', dateDebut: '2026-07-08', statut: 'ouverte');
const _lieu1 = Lieu(id: 'l1', code: 'DK01', nom: 'CAMPUS');
const _lieu2 = Lieu(id: 'l2', code: 'DK02', nom: 'ZOLA');
const _service1 = Service(id: 's1', nom: 'Labo A', lieuId: 'l1');
const _piece1 = Piece(id: 'p1', code: 'DK01-B01-E01-035', libelle: 'HALL', lieuId: 'l1');

void main() {
  late ProviderContainer container;
  SessionController notifier() => container.read(sessionProvider.notifier);
  SessionState etat() => container.read(sessionProvider);

  setUp(() => container = ProviderContainer());
  tearDown(() => container.dispose());

  test('contexte incomplet au départ', () {
    expect(etat().pretAScanner, isFalse);
  });

  test('setLieu réinitialise service et pièce', () {
    notifier().setCampagne(_campagne);
    notifier().setLieu(_lieu1);
    notifier().setService(_service1);
    notifier().setPiece(_piece1);
    expect(etat().pretAScanner, isTrue);

    notifier().setLieu(_lieu2);
    expect(etat().lieu, _lieu2);
    expect(etat().service, isNull);
    expect(etat().piece, isNull);
    expect(etat().pretAScanner, isFalse);
  });

  test('changerPiece garde lieu/service/responsable', () {
    notifier().setCampagne(_campagne);
    notifier().setLieu(_lieu1);
    notifier().setService(_service1);
    notifier().setResponsable('M. Diop');
    notifier().setPiece(_piece1);

    notifier().changerPiece();
    expect(etat().piece, isNull);
    expect(etat().lieu, _lieu1);
    expect(etat().service, _service1);
    expect(etat().responsable, 'M. Diop');
  });

  test('changerContexte repart du lieu mais garde campagne et responsable', () {
    notifier().setCampagne(_campagne);
    notifier().setLieu(_lieu1);
    notifier().setService(_service1);
    notifier().setResponsable('M. Diop');
    notifier().setPiece(_piece1);

    notifier().changerContexte();
    expect(etat().lieu, isNull);
    expect(etat().service, isNull);
    expect(etat().piece, isNull);
    expect(etat().campagne, _campagne);
    expect(etat().responsable, 'M. Diop');
  });

  test('ajouterScan incrémente le compteur et empile les récents', () {
    notifier().setPiece(_piece1);
    for (var i = 0; i < 3; i++) {
      notifier().ajouterScan(ScanRecent(
        numero: 'B$i',
        designation: 'Bien $i',
        etat: EtatConstate.bon,
        horodatage: DateTime(2026, 7, 8, 10, i),
      ));
    }
    expect(etat().nbScans, 3);
    expect(etat().recents.first.numero, 'B2'); // le plus récent en tête
    expect(etat().recents.length, 3);
  });

  test('setPiece vide les récents (nouvelle pièce)', () {
    notifier().setPiece(_piece1);
    notifier().ajouterScan(ScanRecent(
      numero: 'B0', designation: 'x', etat: EtatConstate.bon, horodatage: DateTime(2026)));
    expect(etat().recents, isNotEmpty);
    notifier().setPiece(_piece1);
    expect(etat().recents, isEmpty);
  });
}
