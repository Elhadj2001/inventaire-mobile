enum EtatConstate {
  bon('bon', 'Bon'),
  moyen('moyen', 'Moyen'),
  aReformer('a_reformer', 'À réformer'),
  hs('hs', 'HS');

  const EtatConstate(this.api, this.label);
  final String api;
  final String label;
}

class Lieu {
  final String id;
  final String code;
  final String nom;

  const Lieu({required this.id, required this.code, required this.nom});

  factory Lieu.fromJson(Map<String, dynamic> j) =>
      Lieu(id: j['id'] as String, code: j['code'] as String, nom: j['nom'] as String);
}

class Service {
  final String id;
  final String nom;
  final String lieuId;
  final bool actif;

  const Service({required this.id, required this.nom, required this.lieuId, this.actif = true});

  factory Service.fromJson(Map<String, dynamic> j) => Service(
        id: j['id'] as String,
        nom: j['nom'] as String,
        lieuId: j['lieu_id'] as String,
        actif: j['actif'] as bool? ?? true,
      );
}

class Piece {
  final String id;
  final String code;
  final String libelle;
  final String? batiment;
  final String? niveau;
  final String lieuId;
  final String? serviceId;

  const Piece({
    required this.id,
    required this.code,
    required this.libelle,
    this.batiment,
    this.niveau,
    required this.lieuId,
    this.serviceId,
  });

  factory Piece.fromJson(Map<String, dynamic> j) => Piece(
        id: j['id'] as String,
        code: j['code'] as String,
        libelle: j['libelle'] as String,
        batiment: j['batiment'] as String?,
        niveau: j['niveau'] as String?,
        lieuId: j['lieu_id'] as String,
        serviceId: j['service_id'] as String?,
      );
}

class Campagne {
  final String id;
  final String nom;
  final String dateDebut;
  final String? dateFin;
  final String statut;
  final String? perimetreLieuId;

  const Campagne({
    required this.id,
    required this.nom,
    required this.dateDebut,
    this.dateFin,
    required this.statut,
    this.perimetreLieuId,
  });

  factory Campagne.fromJson(Map<String, dynamic> j) => Campagne(
        id: j['id'] as String,
        nom: j['nom'] as String,
        dateDebut: j['date_debut'] as String,
        dateFin: j['date_fin'] as String?,
        statut: j['statut'] as String,
        perimetreLieuId: j['perimetre_lieu_id'] as String?,
      );
}

class ProgressionLieu {
  final String lieuCode;
  final String lieuNom;
  final int biensActifs;
  final int biensScannes;

  const ProgressionLieu({
    required this.lieuCode,
    required this.lieuNom,
    required this.biensActifs,
    required this.biensScannes,
  });

  factory ProgressionLieu.fromJson(Map<String, dynamic> j) => ProgressionLieu(
        lieuCode: j['lieu_code'] as String,
        lieuNom: j['lieu_nom'] as String,
        biensActifs: j['biens_actifs'] as int,
        biensScannes: j['biens_scannes'] as int,
      );
}

class Progression {
  final int biensActifs;
  final int biensScannes;
  final List<ProgressionLieu> parLieu;

  const Progression({
    required this.biensActifs,
    required this.biensScannes,
    required this.parLieu,
  });

  factory Progression.fromJson(Map<String, dynamic> j) => Progression(
        biensActifs: j['biens_actifs'] as int,
        biensScannes: j['biens_scannes'] as int,
        parLieu: (j['par_lieu'] as List)
            .map((e) => ProgressionLieu.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

/// Résultat d'un POST /lignes-inventaire.
class LigneResultat {
  final String id;
  final bool bienCree;
  final bool dejaEnregistre; // vrai si HTTP 200 (rejeu idempotent)

  const LigneResultat({
    required this.id,
    required this.bienCree,
    required this.dejaEnregistre,
  });
}
