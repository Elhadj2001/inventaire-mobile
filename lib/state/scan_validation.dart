/// Validation anti-fausse-lecture du scanner 1D/QR.
///
/// **Barrière universelle : la double lecture identique** (même valeur lue deux
/// fois dans une fenêtre courte) — c'est elle qui tue les fantômes, car une
/// fausse lecture ne se répète presque jamais à l'identique. Une fois la valeur
/// stabilisée, on **route** selon son contenu :
///  - présente au **cache** → flux normal ;
///  - **plausible** (motif de numéro d'inventaire élargi) mais hors cache →
///    flux « bien non répertorié » (`scan_inconnu`) — surtout **pas** de rejet ;
///  - **non plausible** (code-barres produit EAN‑13, URL de QR marketing…) →
///    rejet silencieux.
library;

/// Résultat d'une tentative de lecture soumise au validateur.
enum EtatLecture {
  /// Première lecture : on attend une confirmation identique avant d'agir.
  premiere,

  /// Stabilisée et présente au cache : bien connu → flux de saisie normal.
  connu,

  /// Stabilisée, plausible mais inconnue du cache : bien réel non répertorié
  /// → flux « à identifier » (dialogue « Enregistrer quand même / Ignorer »).
  nonRepertorie,

  /// Stabilisée mais invraisemblable : ignorée (indicateur « lecture rejetée »).
  rejetee,
}

class ValidateurScan {
  /// Motif des numéros d'inventaire IPD (élargi le 2026-07-12) : **5 à 7 chiffres**,
  /// éventuellement suivis d'une lettre puis d'un chiffre. Le motif initial
  /// (5 chiffres) rejetait à tort des biens réels à 6 chiffres (ex. `751381`)
  /// absents du référentiel. Formes vues sur BIENS.xlsx : `99999`, `99999A`,
  /// `99999A9` ; le parc réel dépasse 5 chiffres, borne haute à 7.
  static final RegExp motifNumero = RegExp(r'^\d{5,7}([A-Za-z]\d?)?$');

  /// Durée maximale entre les deux lectures identiques pour stabiliser.
  final Duration fenetre;

  String? _candidat;
  DateTime? _vuLe;

  ValidateurScan({this.fenetre = const Duration(milliseconds: 1500)});

  /// Vraisemblance : motif d'inventaire respecté OU numéro présent au cache.
  bool estPlausible(String code, Set<String> numerosConnus) =>
      motifNumero.hasMatch(code) || numerosConnus.contains(code);

  /// Soumet une lecture. Double lecture identique universelle, puis routage.
  EtatLecture traiter(String code, Set<String> numerosConnus, DateTime maintenant) {
    final vu = _vuLe;
    final stable =
        _candidat == code && vu != null && maintenant.difference(vu) <= fenetre;
    if (!stable) {
      // Nouvelle valeur (ou fenêtre expirée) : arme la double lecture.
      _candidat = code;
      _vuLe = maintenant;
      return EtatLecture.premiere;
    }
    // Valeur stabilisée : on route.
    _candidat = null;
    _vuLe = null;
    if (numerosConnus.contains(code)) return EtatLecture.connu;
    if (motifNumero.hasMatch(code)) return EtatLecture.nonRepertorie;
    return EtatLecture.rejetee;
  }

  /// Oublie toute lecture en cours (ex. reprise du scanner après navigation).
  void reinitialiser() {
    _candidat = null;
    _vuLe = null;
  }
}
