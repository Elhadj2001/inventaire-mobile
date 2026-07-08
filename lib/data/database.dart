import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

// ------------------------------------------------------------ tables miroir
class LieuxCache extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get nom => text()();
  @override
  Set<Column> get primaryKey => {id};
}

class ServicesCache extends Table {
  TextColumn get id => text()();
  TextColumn get nom => text()();
  TextColumn get lieuId => text()();
  BoolColumn get actif => boolean().withDefault(const Constant(true))();
  @override
  Set<Column> get primaryKey => {id};
}

class PiecesCache extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get libelle => text()();
  TextColumn get batiment => text().nullable()();
  TextColumn get niveau => text().nullable()();
  TextColumn get lieuId => text()();
  TextColumn get serviceId => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class BiensCache extends Table {
  TextColumn get numeroInventaire => text()();
  TextColumn get id => text()();
  TextColumn get designation => text()();
  TextColumn get statut => text()();
  @override
  Set<Column> get primaryKey => {numeroInventaire};
}

// ------------------------------------------------------------ file locale
class ServicesLocaux extends Table {
  TextColumn get localId => text()();
  TextColumn get lieuId => text()();
  TextColumn get nom => text()();
  TextColumn get serverId => text().nullable()(); // rempli après synchro
  @override
  Set<Column> get primaryKey => {localId};
}

class ScansLocaux extends Table {
  TextColumn get id => text()(); // UUID client (idempotence)
  TextColumn get campagneId => text()();
  TextColumn get numeroInventaire => text()();
  TextColumn get pieceId => text()();
  TextColumn get serviceId => text().nullable()(); // id serveur si connu
  TextColumn get serviceLocalId => text().nullable()(); // service provisoire
  TextColumn get responsable => text().nullable()();
  TextColumn get etat => text()();
  TextColumn get commentaire => text().nullable()();
  TextColumn get photoLocale => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  DateTimeColumn get scanneLe => dateTime()();
  TextColumn get statut => text().withDefault(const Constant('en_attente'))(); // en_attente|synchronise|rejete
  TextColumn get motif => text().nullable()();
  DateTimeColumn get creeLe => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class Meta extends Table {
  TextColumn get cle => text()();
  TextColumn get valeur => text()();
  @override
  Set<Column> get primaryKey => {cle};
}

@DriftDatabase(
  tables: [LieuxCache, ServicesCache, PiecesCache, BiensCache, ServicesLocaux, ScansLocaux, Meta],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'inventaire'));

  @override
  int get schemaVersion => 1;

  // ----- meta
  Future<String?> lireMeta(String cle) async {
    final row = await (select(meta)..where((m) => m.cle.equals(cle))).getSingleOrNull();
    return row?.valeur;
  }

  Future<void> ecrireMeta(String cle, String valeur) =>
      into(meta).insertOnConflictUpdate(MetaCompanion.insert(cle: cle, valeur: valeur));

  // ----- résolution locale d'un bien par numéro
  Future<BiensCacheData?> bienParNumero(String numero) =>
      (select(biensCache)..where((b) => b.numeroInventaire.equals(numero.trim()))).getSingleOrNull();

  // ----- file
  Future<int> compterEnAttente() async {
    final q = selectOnly(scansLocaux)
      ..addColumns([scansLocaux.id.count()])
      ..where(scansLocaux.statut.equals('en_attente'));
    final row = await q.getSingle();
    return row.read(scansLocaux.id.count()) ?? 0;
  }

  Future<List<ScansLocauxData>> scansParStatut(String statut) =>
      (select(scansLocaux)..where((s) => s.statut.equals(statut))).get();

  Stream<int> watchEnAttente() {
    final q = selectOnly(scansLocaux)
      ..addColumns([scansLocaux.id.count()])
      ..where(scansLocaux.statut.equals('en_attente'));
    return q.watchSingle().map((row) => row.read(scansLocaux.id.count()) ?? 0);
  }

  Future<List<ScansLocauxData>> tousLesScans() =>
      (select(scansLocaux)..orderBy([(s) => OrderingTerm.desc(s.creeLe)])).get();

  Future<List<ServicesLocauxData>> servicesLocauxNonSync() =>
      (select(servicesLocaux)..where((s) => s.serverId.isNull())).get();

  Future<ServicesLocauxData?> serviceProvisoire(String localId) =>
      (select(servicesLocaux)..where((s) => s.localId.equals(localId))).getSingleOrNull();

  Future<void> remapperService(String localId, String serverId) async {
    await (update(servicesLocaux)..where((s) => s.localId.equals(localId)))
        .write(ServicesLocauxCompanion(serverId: Value(serverId)));
    // reporter l'id serveur sur les scans qui référencent ce service provisoire
    await (update(scansLocaux)..where((s) => s.serviceLocalId.equals(localId)))
        .write(ScansLocauxCompanion(serviceId: Value(serverId)));
  }

  // ----- application du référentiel (upsert en masse)
  Future<void> appliquerReferentiel(Map<String, dynamic> data) async {
    await batch((b) {
      for (final x in (data['lieux'] as List? ?? [])) {
        b.insert(
          lieuxCache,
          LieuxCacheCompanion.insert(id: x['id'], code: x['code'], nom: x['nom']),
          mode: InsertMode.insertOrReplace,
        );
      }
      for (final x in (data['services'] as List? ?? [])) {
        b.insert(
          servicesCache,
          ServicesCacheCompanion.insert(
            id: x['id'],
            nom: x['nom'],
            lieuId: x['lieu_id'],
            actif: Value(x['actif'] as bool? ?? true),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
      for (final x in (data['pieces'] as List? ?? [])) {
        b.insert(
          piecesCache,
          PiecesCacheCompanion.insert(
            id: x['id'],
            code: x['code'],
            libelle: x['libelle'],
            batiment: Value(x['batiment'] as String?),
            niveau: Value(x['niveau'] as String?),
            lieuId: x['lieu_id'],
            serviceId: Value(x['service_id'] as String?),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
      for (final x in (data['biens'] as List? ?? [])) {
        b.insert(
          biensCache,
          BiensCacheCompanion.insert(
            numeroInventaire: x['numero_inventaire'],
            id: x['id'],
            designation: x['designation'],
            statut: x['statut'],
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  // ----- lectures cache pour la mise en contexte (offline)
  Future<List<LieuxCacheData>> lieux() =>
      (select(lieuxCache)..orderBy([(l) => OrderingTerm(expression: l.code)])).get();

  Future<List<ServicesCacheData>> servicesDuLieu(String lieuId) =>
      (select(servicesCache)
            ..where((s) => s.lieuId.equals(lieuId))
            ..orderBy([(s) => OrderingTerm(expression: s.nom)]))
          .get();

  Future<List<PiecesCacheData>> piecesDuLieu(String lieuId, {String? q}) {
    final query = select(piecesCache)..where((p) => p.lieuId.equals(lieuId));
    if (q != null && q.trim().isNotEmpty) {
      final motif = '%${q.trim()}%';
      query.where((p) => p.code.like(motif) | p.libelle.like(motif));
    }
    query
      ..orderBy([(p) => OrderingTerm(expression: p.code)])
      ..limit(100);
    return query.get();
  }

  // ----- file : enfilage + mises à jour
  Future<void> enfilerScan(ScansLocauxCompanion scan) =>
      into(scansLocaux).insertOnConflictUpdate(scan);

  Future<void> creerServiceProvisoire(ServicesLocauxCompanion service) =>
      into(servicesLocaux).insertOnConflictUpdate(service);

  Future<void> definirPhotoUrl(String scanId, String url) =>
      (update(scansLocaux)..where((s) => s.id.equals(scanId)))
          .write(ScansLocauxCompanion(photoUrl: Value(url)));

  Future<List<ScansLocauxData>> scansAvecPhotoAUploader() => (select(scansLocaux)
        ..where((s) =>
            s.statut.equals('en_attente') & s.photoLocale.isNotNull() & s.photoUrl.isNull()))
      .get();

  Future<void> marquerResultat(String scanId, String statut, String? motif) =>
      (update(scansLocaux)..where((s) => s.id.equals(scanId))).write(
        ScansLocauxCompanion(statut: Value(statut), motif: Value(motif)),
      );

  Future<void> viderFile() async {
    await delete(scansLocaux).go();
    await delete(servicesLocaux).go();
  }
}

/// Ouvre une base en mémoire (tests unitaires).
AppDatabase openInMemory() => AppDatabase(NativeDatabase.memory());
