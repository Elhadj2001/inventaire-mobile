import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/data/database.dart';
import 'package:inventaire_mobile/state/scan_validation.dart';

void main() {
  group('motif de vraisemblance (regex numéro IPD)', () {
    final v = ValidateurScan();
    const vide = <String>{};

    test('accepte les 3 formes réelles du parc', () {
      expect(v.estPlausible('10000', vide), isTrue); // 5 chiffres
      expect(v.estPlausible('20437', vide), isTrue); // caisson exemple
      expect(v.estPlausible('20165A', vide), isTrue); // 5 chiffres + lettre
      expect(v.estPlausible('20165C1', vide), isTrue); // 5 chiffres + lettre + chiffre
    });

    test('rejette les valeurs invraisemblables (fausses lectures typiques)', () {
      expect(v.estPlausible('1234', vide), isFalse); // trop court
      expect(v.estPlausible('123456', vide), isFalse); // 6 chiffres purs : n'existe pas
      expect(v.estPlausible('ABCDEF', vide), isFalse); // que des lettres
      expect(v.estPlausible('20165CC', vide), isFalse); // deux lettres
      expect(v.estPlausible('0000000000000', vide), isFalse); // code ITF fantôme
      expect(v.estPlausible('', vide), isFalse);
    });

    test('un numéro non conforme au motif mais présent au cache est plausible', () {
      expect(v.estPlausible('X-SPECIAL-9', {'X-SPECIAL-9'}), isTrue);
      expect(v.estPlausible('X-SPECIAL-9', const {}), isFalse);
    });
  });

  group('double lecture', () {
    const vide = <String>{};
    final t0 = DateTime(2026, 7, 12, 10, 0, 0);

    test('première lecture = premiere, deuxième identique = confirmee', () {
      final v = ValidateurScan();
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      expect(v.traiter('10001', vide, t0.add(const Duration(milliseconds: 300))),
          EtatLecture.confirmee);
    });

    test('deux lectures différentes ne confirment pas', () {
      final v = ValidateurScan();
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      expect(v.traiter('10002', vide, t0.add(const Duration(milliseconds: 200))),
          EtatLecture.premiere);
    });

    test('confirmation hors fenêtre repart à zéro', () {
      final v = ValidateurScan(fenetre: const Duration(milliseconds: 500));
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      // 800 ms > fenêtre 500 ms : redevient une première lecture
      expect(v.traiter('10001', vide, t0.add(const Duration(milliseconds: 800))),
          EtatLecture.premiere);
    });

    test('lecture invraisemblable = rejetee et réinitialise le candidat', () {
      final v = ValidateurScan();
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      // une fausse lecture au milieu casse la séquence
      expect(v.traiter('99', vide, t0.add(const Duration(milliseconds: 100))),
          EtatLecture.rejetee);
      // la lecture identique suivante redevient une première (pas une confirmation)
      expect(v.traiter('10001', vide, t0.add(const Duration(milliseconds: 200))),
          EtatLecture.premiere);
    });
  });

  test('numerosConnus() renvoie l\'ensemble des numéros du cache', () async {
    final db = openInMemory();
    for (final n in ['10000', '20165C1', '30500A']) {
      await db.into(db.biensCache).insert(
            BiensCacheCompanion.insert(
              numeroInventaire: n,
              id: 'id-$n',
              designation: 'Bien $n',
              statut: 'actif',
            ),
          );
    }
    final numeros = await db.numerosConnus();
    expect(numeros, {'10000', '20165C1', '30500A'});
    await db.close();
  });
}
