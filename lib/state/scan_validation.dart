/// Validation anti-fausse-lecture du scanner 1D/QR.
///
/// Deux barrières, dans cet ordre :
///  1. **vraisemblance** : la valeur ressemble à un numéro d'inventaire IPD
///     (motif exact ci-dessous) OU existe dans le cache local du référentiel ;
///  2. **double lecture** : la valeur n'est acceptée que si elle est lue deux
///     fois consécutivement à l'identique dans une fenêtre courte.
///
/// Une lecture non plausible est rejetée silencieusement (aucune navigation).
library;

/// Résultat d'une tentative de lecture soumise au validateur.
enum EtatLecture {
  /// Valeur invraisemblable : ignorée (indicateur discret « lecture rejetée »).
  rejetee,

  /// Première lecture plausible : on attend une confirmation identique.
  premiere,

  /// Deuxième lecture identique dans la fenêtre : valeur confirmée.
  confirmee,
}

class ValidateurScan {
  /// Motif exact des numéros d'inventaire IPD, vérifié sur les 10 092 numéros
  /// du parc (2026-07-12) : **5 chiffres**, éventuellement suivis d'une lettre,
  /// puis éventuellement d'un chiffre (uniquement après la lettre).
  /// Formes réelles observées : `99999` (9653), `99999A` (431), `99999A9` (8,
  /// ex. `20165C1`). Aucun numéro à 6 chiffres purs.
  static final RegExp motifNumero = RegExp(r'^\d{5}([A-Za-z]\d?)?$');

  /// Durée maximale entre les deux lectures identiques pour valider.
  final Duration fenetre;

  String? _candidat;
  DateTime? _vuLe;

  ValidateurScan({this.fenetre = const Duration(milliseconds: 1500)});

  /// Vraisemblance : motif d'inventaire respecté OU numéro présent au cache.
  bool estPlausible(String code, Set<String> numerosConnus) =>
      motifNumero.hasMatch(code) || numerosConnus.contains(code);

  /// Soumet une lecture.
  ///
  /// - Numéro **connu du cache** (réel) : accepté immédiatement (le cas courant,
  ///   scanner un bien du référentiel — pas besoin d'une seconde lecture).
  /// - Numéro plausible mais **inconnu** du cache : double lecture exigée.
  /// - Lecture **invraisemblable** : ignorée, **sans** casser le candidat en cours
  ///   (une frame parasite ne doit pas annuler une confirmation en approche).
  EtatLecture traiter(String code, Set<String> numerosConnus, DateTime maintenant) {
    final connu = numerosConnus.contains(code);
    if (!connu && !motifNumero.hasMatch(code)) {
      return EtatLecture.rejetee;
    }
    if (connu) {
      _candidat = null;
      _vuLe = null;
      return EtatLecture.confirmee;
    }
    final vu = _vuLe;
    if (_candidat == code && vu != null && maintenant.difference(vu) <= fenetre) {
      _candidat = null;
      _vuLe = null;
      return EtatLecture.confirmee;
    }
    _candidat = code;
    _vuLe = maintenant;
    return EtatLecture.premiere;
  }

  /// Oublie toute lecture en cours (ex. reprise du scanner après navigation).
  void reinitialiser() {
    _candidat = null;
    _vuLe = null;
  }
}
