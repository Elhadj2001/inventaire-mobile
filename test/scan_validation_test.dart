import 'package:flutter_test/flutter_test.dart';
import 'package:inventaire_mobile/data/database.dart';
import 'package:inventaire_mobile/state/scan_validation.dart';

void main() {
  group('motif de vraisemblance (regex numéro IPD élargi 5-7 chiffres)', () {
    final v = ValidateurScan();
    const vide = <String>{};

    test('accepte 5, 6 et 7 chiffres + suffixes', () {
      expect(v.estPlausible('10000', vide), isTrue); // 5 chiffres
      expect(v.estPlausible('20437', vide), isTrue); // caisson Code 39
      expect(v.estPlausible('751381', vide), isTrue); // 6 chiffres (bien réel)
      expect(v.estPlausible('1234567', vide), isTrue); // 7 chiffres
      expect(v.estPlausible('20165A', vide), isTrue); // 5 chiffres + lettre
      expect(v.estPlausible('20165C1', vide), isTrue); // + lettre + chiffre
    });

    test('rejette hors motif (produit / bruit)', () {
      expect(v.estPlausible('1234', vide), isFalse); // 4 chiffres
      expect(v.estPlausible('12345678', vide), isFalse); // 8 chiffres
      expect(v.estPlausible('3017620422003', vide), isFalse); // EAN-13 produit
      expect(v.estPlausible('ABCDEF', vide), isFalse);
      expect(v.estPlausible('20165CC', vide), isFalse); // deux lettres
      expect(v.estPlausible('', vide), isFalse);
    });

    test('un code hors motif mais présent au cache reste plausible', () {
      expect(v.estPlausible('X-SPECIAL', {'X-SPECIAL'}), isTrue);
      expect(v.estPlausible('X-SPECIAL', const {}), isFalse);
    });
  });

  group('double lecture universelle + routage', () {
    const vide = <String>{};
    final t0 = DateTime(2026, 7, 12, 10, 0, 0);
    Duration ms(int n) => Duration(milliseconds: n);

    test('bien connu du cache : première puis routé « connu »', () {
      final v = ValidateurScan();
      expect(v.traiter('22788', {'22788'}, t0), EtatLecture.premiere);
      expect(v.traiter('22788', {'22788'}, t0.add(ms(300))), EtatLecture.connu);
    });

    test('6 chiffres hors cache : première puis routé « non répertorié »', () {
      final v = ValidateurScan();
      expect(v.traiter('751381', vide, t0), EtatLecture.premiere);
      expect(v.traiter('751381', vide, t0.add(ms(300))), EtatLecture.nonRepertorie);
    });

    test('code produit (EAN-13) : stabilisé puis rejeté silencieusement', () {
      final v = ValidateurScan();
      expect(v.traiter('3017620422003', vide, t0), EtatLecture.premiere);
      expect(v.traiter('3017620422003', vide, t0.add(ms(300))), EtatLecture.rejetee);
    });

    test('deux lectures différentes ne se stabilisent pas', () {
      final v = ValidateurScan();
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      expect(v.traiter('10002', vide, t0.add(ms(200))), EtatLecture.premiere);
    });

    test('confirmation hors fenêtre repart à zéro', () {
      final v = ValidateurScan(fenetre: ms(500));
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      expect(v.traiter('10001', vide, t0.add(ms(800))), EtatLecture.premiere);
    });

    test('reinitialiser oublie le candidat en cours', () {
      final v = ValidateurScan();
      expect(v.traiter('10001', vide, t0), EtatLecture.premiere);
      v.reinitialiser();
      expect(v.traiter('10001', vide, t0.add(ms(200))), EtatLecture.premiere);
    });
  });

  test('numerosConnus() renvoie l\'ensemble des numéros du cache', () async {
    final db = openInMemory();
    for (final n in ['10000', '751381', '20165C1']) {
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
    expect(numeros, {'10000', '751381', '20165C1'});
    await db.close();
  });
}
