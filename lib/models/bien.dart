class LieuRef {
  final String code;
  final String nom;

  const LieuRef({required this.code, required this.nom});

  factory LieuRef.fromJson(Map<String, dynamic> json) =>
      LieuRef(code: json['code'] as String, nom: json['nom'] as String);
}

class PieceRef {
  final String code;
  final String libelle;
  final String? batiment;
  final String? niveau;
  final LieuRef lieu;

  const PieceRef({
    required this.code,
    required this.libelle,
    this.batiment,
    this.niveau,
    required this.lieu,
  });

  factory PieceRef.fromJson(Map<String, dynamic> json) => PieceRef(
        code: json['code'] as String,
        libelle: json['libelle'] as String,
        batiment: json['batiment'] as String?,
        niveau: json['niveau'] as String?,
        lieu: LieuRef.fromJson(json['lieu'] as Map<String, dynamic>),
      );
}

class Bien {
  final String numeroInventaire;
  final String designation;
  final String statut;
  final String? etat;
  final String source;
  final String? photoUrl;
  final PieceRef? piece;

  const Bien({
    required this.numeroInventaire,
    required this.designation,
    required this.statut,
    this.etat,
    required this.source,
    this.photoUrl,
    this.piece,
  });

  factory Bien.fromJson(Map<String, dynamic> json) => Bien(
        numeroInventaire: json['numero_inventaire'] as String,
        designation: json['designation'] as String,
        statut: json['statut'] as String,
        etat: json['etat'] as String?,
        source: json['source'] as String,
        photoUrl: json['photo_url'] as String?,
        piece: json['piece'] == null
            ? null
            : PieceRef.fromJson(json['piece'] as Map<String, dynamic>),
      );
}
