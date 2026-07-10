// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LieuxCacheTable extends LieuxCache
    with TableInfo<$LieuxCacheTable, LieuxCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LieuxCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, code, nom];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lieux_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<LieuxCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LieuxCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LieuxCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
    );
  }

  @override
  $LieuxCacheTable createAlias(String alias) {
    return $LieuxCacheTable(attachedDatabase, alias);
  }
}

class LieuxCacheData extends DataClass implements Insertable<LieuxCacheData> {
  final String id;
  final String code;
  final String nom;
  const LieuxCacheData({
    required this.id,
    required this.code,
    required this.nom,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['nom'] = Variable<String>(nom);
    return map;
  }

  LieuxCacheCompanion toCompanion(bool nullToAbsent) {
    return LieuxCacheCompanion(
      id: Value(id),
      code: Value(code),
      nom: Value(nom),
    );
  }

  factory LieuxCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LieuxCacheData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      nom: serializer.fromJson<String>(json['nom']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'nom': serializer.toJson<String>(nom),
    };
  }

  LieuxCacheData copyWith({String? id, String? code, String? nom}) =>
      LieuxCacheData(
        id: id ?? this.id,
        code: code ?? this.code,
        nom: nom ?? this.nom,
      );
  LieuxCacheData copyWithCompanion(LieuxCacheCompanion data) {
    return LieuxCacheData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      nom: data.nom.present ? data.nom.value : this.nom,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LieuxCacheData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nom: $nom')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, code, nom);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LieuxCacheData &&
          other.id == this.id &&
          other.code == this.code &&
          other.nom == this.nom);
}

class LieuxCacheCompanion extends UpdateCompanion<LieuxCacheData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> nom;
  final Value<int> rowid;
  const LieuxCacheCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.nom = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LieuxCacheCompanion.insert({
    required String id,
    required String code,
    required String nom,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       nom = Value(nom);
  static Insertable<LieuxCacheData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? nom,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (nom != null) 'nom': nom,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LieuxCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? nom,
    Value<int>? rowid,
  }) {
    return LieuxCacheCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      nom: nom ?? this.nom,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LieuxCacheCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('nom: $nom, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesCacheTable extends ServicesCache
    with TableInfo<$ServicesCacheTable, ServicesCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lieuIdMeta = const VerificationMeta('lieuId');
  @override
  late final GeneratedColumn<String> lieuId = GeneratedColumn<String>(
    'lieu_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actifMeta = const VerificationMeta('actif');
  @override
  late final GeneratedColumn<bool> actif = GeneratedColumn<bool>(
    'actif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("actif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nom, lieuId, actif];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServicesCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('lieu_id')) {
      context.handle(
        _lieuIdMeta,
        lieuId.isAcceptableOrUnknown(data['lieu_id']!, _lieuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lieuIdMeta);
    }
    if (data.containsKey('actif')) {
      context.handle(
        _actifMeta,
        actif.isAcceptableOrUnknown(data['actif']!, _actifMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServicesCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServicesCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      lieuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lieu_id'],
      )!,
      actif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}actif'],
      )!,
    );
  }

  @override
  $ServicesCacheTable createAlias(String alias) {
    return $ServicesCacheTable(attachedDatabase, alias);
  }
}

class ServicesCacheData extends DataClass
    implements Insertable<ServicesCacheData> {
  final String id;
  final String nom;
  final String lieuId;
  final bool actif;
  const ServicesCacheData({
    required this.id,
    required this.nom,
    required this.lieuId,
    required this.actif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nom'] = Variable<String>(nom);
    map['lieu_id'] = Variable<String>(lieuId);
    map['actif'] = Variable<bool>(actif);
    return map;
  }

  ServicesCacheCompanion toCompanion(bool nullToAbsent) {
    return ServicesCacheCompanion(
      id: Value(id),
      nom: Value(nom),
      lieuId: Value(lieuId),
      actif: Value(actif),
    );
  }

  factory ServicesCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServicesCacheData(
      id: serializer.fromJson<String>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      lieuId: serializer.fromJson<String>(json['lieuId']),
      actif: serializer.fromJson<bool>(json['actif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nom': serializer.toJson<String>(nom),
      'lieuId': serializer.toJson<String>(lieuId),
      'actif': serializer.toJson<bool>(actif),
    };
  }

  ServicesCacheData copyWith({
    String? id,
    String? nom,
    String? lieuId,
    bool? actif,
  }) => ServicesCacheData(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    lieuId: lieuId ?? this.lieuId,
    actif: actif ?? this.actif,
  );
  ServicesCacheData copyWithCompanion(ServicesCacheCompanion data) {
    return ServicesCacheData(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      lieuId: data.lieuId.present ? data.lieuId.value : this.lieuId,
      actif: data.actif.present ? data.actif.value : this.actif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCacheData(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('lieuId: $lieuId, ')
          ..write('actif: $actif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nom, lieuId, actif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServicesCacheData &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.lieuId == this.lieuId &&
          other.actif == this.actif);
}

class ServicesCacheCompanion extends UpdateCompanion<ServicesCacheData> {
  final Value<String> id;
  final Value<String> nom;
  final Value<String> lieuId;
  final Value<bool> actif;
  final Value<int> rowid;
  const ServicesCacheCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.lieuId = const Value.absent(),
    this.actif = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesCacheCompanion.insert({
    required String id,
    required String nom,
    required String lieuId,
    this.actif = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nom = Value(nom),
       lieuId = Value(lieuId);
  static Insertable<ServicesCacheData> custom({
    Expression<String>? id,
    Expression<String>? nom,
    Expression<String>? lieuId,
    Expression<bool>? actif,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (lieuId != null) 'lieu_id': lieuId,
      if (actif != null) 'actif': actif,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? nom,
    Value<String>? lieuId,
    Value<bool>? actif,
    Value<int>? rowid,
  }) {
    return ServicesCacheCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      lieuId: lieuId ?? this.lieuId,
      actif: actif ?? this.actif,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (lieuId.present) {
      map['lieu_id'] = Variable<String>(lieuId.value);
    }
    if (actif.present) {
      map['actif'] = Variable<bool>(actif.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCacheCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('lieuId: $lieuId, ')
          ..write('actif: $actif, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PiecesCacheTable extends PiecesCache
    with TableInfo<$PiecesCacheTable, PiecesCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PiecesCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _libelleMeta = const VerificationMeta(
    'libelle',
  );
  @override
  late final GeneratedColumn<String> libelle = GeneratedColumn<String>(
    'libelle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batimentMeta = const VerificationMeta(
    'batiment',
  );
  @override
  late final GeneratedColumn<String> batiment = GeneratedColumn<String>(
    'batiment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _niveauMeta = const VerificationMeta('niveau');
  @override
  late final GeneratedColumn<String> niveau = GeneratedColumn<String>(
    'niveau',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lieuIdMeta = const VerificationMeta('lieuId');
  @override
  late final GeneratedColumn<String> lieuId = GeneratedColumn<String>(
    'lieu_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    libelle,
    batiment,
    niveau,
    lieuId,
    serviceId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pieces_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<PiecesCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('libelle')) {
      context.handle(
        _libelleMeta,
        libelle.isAcceptableOrUnknown(data['libelle']!, _libelleMeta),
      );
    } else if (isInserting) {
      context.missing(_libelleMeta);
    }
    if (data.containsKey('batiment')) {
      context.handle(
        _batimentMeta,
        batiment.isAcceptableOrUnknown(data['batiment']!, _batimentMeta),
      );
    }
    if (data.containsKey('niveau')) {
      context.handle(
        _niveauMeta,
        niveau.isAcceptableOrUnknown(data['niveau']!, _niveauMeta),
      );
    }
    if (data.containsKey('lieu_id')) {
      context.handle(
        _lieuIdMeta,
        lieuId.isAcceptableOrUnknown(data['lieu_id']!, _lieuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lieuIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PiecesCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PiecesCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      libelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}libelle'],
      )!,
      batiment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batiment'],
      ),
      niveau: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niveau'],
      ),
      lieuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lieu_id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      ),
    );
  }

  @override
  $PiecesCacheTable createAlias(String alias) {
    return $PiecesCacheTable(attachedDatabase, alias);
  }
}

class PiecesCacheData extends DataClass implements Insertable<PiecesCacheData> {
  final String id;
  final String code;
  final String libelle;
  final String? batiment;
  final String? niveau;
  final String lieuId;
  final String? serviceId;
  const PiecesCacheData({
    required this.id,
    required this.code,
    required this.libelle,
    this.batiment,
    this.niveau,
    required this.lieuId,
    this.serviceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['libelle'] = Variable<String>(libelle);
    if (!nullToAbsent || batiment != null) {
      map['batiment'] = Variable<String>(batiment);
    }
    if (!nullToAbsent || niveau != null) {
      map['niveau'] = Variable<String>(niveau);
    }
    map['lieu_id'] = Variable<String>(lieuId);
    if (!nullToAbsent || serviceId != null) {
      map['service_id'] = Variable<String>(serviceId);
    }
    return map;
  }

  PiecesCacheCompanion toCompanion(bool nullToAbsent) {
    return PiecesCacheCompanion(
      id: Value(id),
      code: Value(code),
      libelle: Value(libelle),
      batiment: batiment == null && nullToAbsent
          ? const Value.absent()
          : Value(batiment),
      niveau: niveau == null && nullToAbsent
          ? const Value.absent()
          : Value(niveau),
      lieuId: Value(lieuId),
      serviceId: serviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceId),
    );
  }

  factory PiecesCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PiecesCacheData(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      libelle: serializer.fromJson<String>(json['libelle']),
      batiment: serializer.fromJson<String?>(json['batiment']),
      niveau: serializer.fromJson<String?>(json['niveau']),
      lieuId: serializer.fromJson<String>(json['lieuId']),
      serviceId: serializer.fromJson<String?>(json['serviceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'libelle': serializer.toJson<String>(libelle),
      'batiment': serializer.toJson<String?>(batiment),
      'niveau': serializer.toJson<String?>(niveau),
      'lieuId': serializer.toJson<String>(lieuId),
      'serviceId': serializer.toJson<String?>(serviceId),
    };
  }

  PiecesCacheData copyWith({
    String? id,
    String? code,
    String? libelle,
    Value<String?> batiment = const Value.absent(),
    Value<String?> niveau = const Value.absent(),
    String? lieuId,
    Value<String?> serviceId = const Value.absent(),
  }) => PiecesCacheData(
    id: id ?? this.id,
    code: code ?? this.code,
    libelle: libelle ?? this.libelle,
    batiment: batiment.present ? batiment.value : this.batiment,
    niveau: niveau.present ? niveau.value : this.niveau,
    lieuId: lieuId ?? this.lieuId,
    serviceId: serviceId.present ? serviceId.value : this.serviceId,
  );
  PiecesCacheData copyWithCompanion(PiecesCacheCompanion data) {
    return PiecesCacheData(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      libelle: data.libelle.present ? data.libelle.value : this.libelle,
      batiment: data.batiment.present ? data.batiment.value : this.batiment,
      niveau: data.niveau.present ? data.niveau.value : this.niveau,
      lieuId: data.lieuId.present ? data.lieuId.value : this.lieuId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PiecesCacheData(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('batiment: $batiment, ')
          ..write('niveau: $niveau, ')
          ..write('lieuId: $lieuId, ')
          ..write('serviceId: $serviceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, libelle, batiment, niveau, lieuId, serviceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PiecesCacheData &&
          other.id == this.id &&
          other.code == this.code &&
          other.libelle == this.libelle &&
          other.batiment == this.batiment &&
          other.niveau == this.niveau &&
          other.lieuId == this.lieuId &&
          other.serviceId == this.serviceId);
}

class PiecesCacheCompanion extends UpdateCompanion<PiecesCacheData> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> libelle;
  final Value<String?> batiment;
  final Value<String?> niveau;
  final Value<String> lieuId;
  final Value<String?> serviceId;
  final Value<int> rowid;
  const PiecesCacheCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.libelle = const Value.absent(),
    this.batiment = const Value.absent(),
    this.niveau = const Value.absent(),
    this.lieuId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PiecesCacheCompanion.insert({
    required String id,
    required String code,
    required String libelle,
    this.batiment = const Value.absent(),
    this.niveau = const Value.absent(),
    required String lieuId,
    this.serviceId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       libelle = Value(libelle),
       lieuId = Value(lieuId);
  static Insertable<PiecesCacheData> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? libelle,
    Expression<String>? batiment,
    Expression<String>? niveau,
    Expression<String>? lieuId,
    Expression<String>? serviceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (libelle != null) 'libelle': libelle,
      if (batiment != null) 'batiment': batiment,
      if (niveau != null) 'niveau': niveau,
      if (lieuId != null) 'lieu_id': lieuId,
      if (serviceId != null) 'service_id': serviceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PiecesCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? libelle,
    Value<String?>? batiment,
    Value<String?>? niveau,
    Value<String>? lieuId,
    Value<String?>? serviceId,
    Value<int>? rowid,
  }) {
    return PiecesCacheCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      libelle: libelle ?? this.libelle,
      batiment: batiment ?? this.batiment,
      niveau: niveau ?? this.niveau,
      lieuId: lieuId ?? this.lieuId,
      serviceId: serviceId ?? this.serviceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (libelle.present) {
      map['libelle'] = Variable<String>(libelle.value);
    }
    if (batiment.present) {
      map['batiment'] = Variable<String>(batiment.value);
    }
    if (niveau.present) {
      map['niveau'] = Variable<String>(niveau.value);
    }
    if (lieuId.present) {
      map['lieu_id'] = Variable<String>(lieuId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PiecesCacheCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('libelle: $libelle, ')
          ..write('batiment: $batiment, ')
          ..write('niveau: $niveau, ')
          ..write('lieuId: $lieuId, ')
          ..write('serviceId: $serviceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BiensCacheTable extends BiensCache
    with TableInfo<$BiensCacheTable, BiensCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BiensCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numeroInventaireMeta = const VerificationMeta(
    'numeroInventaire',
  );
  @override
  late final GeneratedColumn<String> numeroInventaire = GeneratedColumn<String>(
    'numero_inventaire',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    numeroInventaire,
    id,
    designation,
    statut,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'biens_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<BiensCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('numero_inventaire')) {
      context.handle(
        _numeroInventaireMeta,
        numeroInventaire.isAcceptableOrUnknown(
          data['numero_inventaire']!,
          _numeroInventaireMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numeroInventaireMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_designationMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    } else if (isInserting) {
      context.missing(_statutMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {numeroInventaire};
  @override
  BiensCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BiensCacheData(
      numeroInventaire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_inventaire'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
    );
  }

  @override
  $BiensCacheTable createAlias(String alias) {
    return $BiensCacheTable(attachedDatabase, alias);
  }
}

class BiensCacheData extends DataClass implements Insertable<BiensCacheData> {
  final String numeroInventaire;
  final String id;
  final String designation;
  final String statut;
  const BiensCacheData({
    required this.numeroInventaire,
    required this.id,
    required this.designation,
    required this.statut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['numero_inventaire'] = Variable<String>(numeroInventaire);
    map['id'] = Variable<String>(id);
    map['designation'] = Variable<String>(designation);
    map['statut'] = Variable<String>(statut);
    return map;
  }

  BiensCacheCompanion toCompanion(bool nullToAbsent) {
    return BiensCacheCompanion(
      numeroInventaire: Value(numeroInventaire),
      id: Value(id),
      designation: Value(designation),
      statut: Value(statut),
    );
  }

  factory BiensCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BiensCacheData(
      numeroInventaire: serializer.fromJson<String>(json['numeroInventaire']),
      id: serializer.fromJson<String>(json['id']),
      designation: serializer.fromJson<String>(json['designation']),
      statut: serializer.fromJson<String>(json['statut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'numeroInventaire': serializer.toJson<String>(numeroInventaire),
      'id': serializer.toJson<String>(id),
      'designation': serializer.toJson<String>(designation),
      'statut': serializer.toJson<String>(statut),
    };
  }

  BiensCacheData copyWith({
    String? numeroInventaire,
    String? id,
    String? designation,
    String? statut,
  }) => BiensCacheData(
    numeroInventaire: numeroInventaire ?? this.numeroInventaire,
    id: id ?? this.id,
    designation: designation ?? this.designation,
    statut: statut ?? this.statut,
  );
  BiensCacheData copyWithCompanion(BiensCacheCompanion data) {
    return BiensCacheData(
      numeroInventaire: data.numeroInventaire.present
          ? data.numeroInventaire.value
          : this.numeroInventaire,
      id: data.id.present ? data.id.value : this.id,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      statut: data.statut.present ? data.statut.value : this.statut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BiensCacheData(')
          ..write('numeroInventaire: $numeroInventaire, ')
          ..write('id: $id, ')
          ..write('designation: $designation, ')
          ..write('statut: $statut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(numeroInventaire, id, designation, statut);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BiensCacheData &&
          other.numeroInventaire == this.numeroInventaire &&
          other.id == this.id &&
          other.designation == this.designation &&
          other.statut == this.statut);
}

class BiensCacheCompanion extends UpdateCompanion<BiensCacheData> {
  final Value<String> numeroInventaire;
  final Value<String> id;
  final Value<String> designation;
  final Value<String> statut;
  final Value<int> rowid;
  const BiensCacheCompanion({
    this.numeroInventaire = const Value.absent(),
    this.id = const Value.absent(),
    this.designation = const Value.absent(),
    this.statut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BiensCacheCompanion.insert({
    required String numeroInventaire,
    required String id,
    required String designation,
    required String statut,
    this.rowid = const Value.absent(),
  }) : numeroInventaire = Value(numeroInventaire),
       id = Value(id),
       designation = Value(designation),
       statut = Value(statut);
  static Insertable<BiensCacheData> custom({
    Expression<String>? numeroInventaire,
    Expression<String>? id,
    Expression<String>? designation,
    Expression<String>? statut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (numeroInventaire != null) 'numero_inventaire': numeroInventaire,
      if (id != null) 'id': id,
      if (designation != null) 'designation': designation,
      if (statut != null) 'statut': statut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BiensCacheCompanion copyWith({
    Value<String>? numeroInventaire,
    Value<String>? id,
    Value<String>? designation,
    Value<String>? statut,
    Value<int>? rowid,
  }) {
    return BiensCacheCompanion(
      numeroInventaire: numeroInventaire ?? this.numeroInventaire,
      id: id ?? this.id,
      designation: designation ?? this.designation,
      statut: statut ?? this.statut,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (numeroInventaire.present) {
      map['numero_inventaire'] = Variable<String>(numeroInventaire.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BiensCacheCompanion(')
          ..write('numeroInventaire: $numeroInventaire, ')
          ..write('id: $id, ')
          ..write('designation: $designation, ')
          ..write('statut: $statut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesLocauxTable extends ServicesLocaux
    with TableInfo<$ServicesLocauxTable, ServicesLocauxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesLocauxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lieuIdMeta = const VerificationMeta('lieuId');
  @override
  late final GeneratedColumn<String> lieuId = GeneratedColumn<String>(
    'lieu_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [localId, lieuId, nom, serverId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services_locaux';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServicesLocauxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('lieu_id')) {
      context.handle(
        _lieuIdMeta,
        lieuId.isAcceptableOrUnknown(data['lieu_id']!, _lieuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lieuIdMeta);
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    } else if (isInserting) {
      context.missing(_nomMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  ServicesLocauxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServicesLocauxData(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      lieuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lieu_id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
    );
  }

  @override
  $ServicesLocauxTable createAlias(String alias) {
    return $ServicesLocauxTable(attachedDatabase, alias);
  }
}

class ServicesLocauxData extends DataClass
    implements Insertable<ServicesLocauxData> {
  final String localId;
  final String lieuId;
  final String nom;
  final String? serverId;
  const ServicesLocauxData({
    required this.localId,
    required this.lieuId,
    required this.nom,
    this.serverId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<String>(localId);
    map['lieu_id'] = Variable<String>(lieuId);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    return map;
  }

  ServicesLocauxCompanion toCompanion(bool nullToAbsent) {
    return ServicesLocauxCompanion(
      localId: Value(localId),
      lieuId: Value(lieuId),
      nom: Value(nom),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
    );
  }

  factory ServicesLocauxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServicesLocauxData(
      localId: serializer.fromJson<String>(json['localId']),
      lieuId: serializer.fromJson<String>(json['lieuId']),
      nom: serializer.fromJson<String>(json['nom']),
      serverId: serializer.fromJson<String?>(json['serverId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<String>(localId),
      'lieuId': serializer.toJson<String>(lieuId),
      'nom': serializer.toJson<String>(nom),
      'serverId': serializer.toJson<String?>(serverId),
    };
  }

  ServicesLocauxData copyWith({
    String? localId,
    String? lieuId,
    String? nom,
    Value<String?> serverId = const Value.absent(),
  }) => ServicesLocauxData(
    localId: localId ?? this.localId,
    lieuId: lieuId ?? this.lieuId,
    nom: nom ?? this.nom,
    serverId: serverId.present ? serverId.value : this.serverId,
  );
  ServicesLocauxData copyWithCompanion(ServicesLocauxCompanion data) {
    return ServicesLocauxData(
      localId: data.localId.present ? data.localId.value : this.localId,
      lieuId: data.lieuId.present ? data.lieuId.value : this.lieuId,
      nom: data.nom.present ? data.nom.value : this.nom,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServicesLocauxData(')
          ..write('localId: $localId, ')
          ..write('lieuId: $lieuId, ')
          ..write('nom: $nom, ')
          ..write('serverId: $serverId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(localId, lieuId, nom, serverId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServicesLocauxData &&
          other.localId == this.localId &&
          other.lieuId == this.lieuId &&
          other.nom == this.nom &&
          other.serverId == this.serverId);
}

class ServicesLocauxCompanion extends UpdateCompanion<ServicesLocauxData> {
  final Value<String> localId;
  final Value<String> lieuId;
  final Value<String> nom;
  final Value<String?> serverId;
  final Value<int> rowid;
  const ServicesLocauxCompanion({
    this.localId = const Value.absent(),
    this.lieuId = const Value.absent(),
    this.nom = const Value.absent(),
    this.serverId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesLocauxCompanion.insert({
    required String localId,
    required String lieuId,
    required String nom,
    this.serverId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : localId = Value(localId),
       lieuId = Value(lieuId),
       nom = Value(nom);
  static Insertable<ServicesLocauxData> custom({
    Expression<String>? localId,
    Expression<String>? lieuId,
    Expression<String>? nom,
    Expression<String>? serverId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (lieuId != null) 'lieu_id': lieuId,
      if (nom != null) 'nom': nom,
      if (serverId != null) 'server_id': serverId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesLocauxCompanion copyWith({
    Value<String>? localId,
    Value<String>? lieuId,
    Value<String>? nom,
    Value<String?>? serverId,
    Value<int>? rowid,
  }) {
    return ServicesLocauxCompanion(
      localId: localId ?? this.localId,
      lieuId: lieuId ?? this.lieuId,
      nom: nom ?? this.nom,
      serverId: serverId ?? this.serverId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (lieuId.present) {
      map['lieu_id'] = Variable<String>(lieuId.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesLocauxCompanion(')
          ..write('localId: $localId, ')
          ..write('lieuId: $lieuId, ')
          ..write('nom: $nom, ')
          ..write('serverId: $serverId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScansLocauxTable extends ScansLocaux
    with TableInfo<$ScansLocauxTable, ScansLocauxData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScansLocauxTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _campagneIdMeta = const VerificationMeta(
    'campagneId',
  );
  @override
  late final GeneratedColumn<String> campagneId = GeneratedColumn<String>(
    'campagne_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroInventaireMeta = const VerificationMeta(
    'numeroInventaire',
  );
  @override
  late final GeneratedColumn<String> numeroInventaire = GeneratedColumn<String>(
    'numero_inventaire',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pieceIdMeta = const VerificationMeta(
    'pieceId',
  );
  @override
  late final GeneratedColumn<String> pieceId = GeneratedColumn<String>(
    'piece_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceLocalIdMeta = const VerificationMeta(
    'serviceLocalId',
  );
  @override
  late final GeneratedColumn<String> serviceLocalId = GeneratedColumn<String>(
    'service_local_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responsableMeta = const VerificationMeta(
    'responsable',
  );
  @override
  late final GeneratedColumn<String> responsable = GeneratedColumn<String>(
    'responsable',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _etatMeta = const VerificationMeta('etat');
  @override
  late final GeneratedColumn<String> etat = GeneratedColumn<String>(
    'etat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentaireMeta = const VerificationMeta(
    'commentaire',
  );
  @override
  late final GeneratedColumn<String> commentaire = GeneratedColumn<String>(
    'commentaire',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoLocaleMeta = const VerificationMeta(
    'photoLocale',
  );
  @override
  late final GeneratedColumn<String> photoLocale = GeneratedColumn<String>(
    'photo_locale',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scanneLeMeta = const VerificationMeta(
    'scanneLe',
  );
  @override
  late final GeneratedColumn<DateTime> scanneLe = GeneratedColumn<DateTime>(
    'scanne_le',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statutMeta = const VerificationMeta('statut');
  @override
  late final GeneratedColumn<String> statut = GeneratedColumn<String>(
    'statut',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en_attente'),
  );
  static const VerificationMeta _motifMeta = const VerificationMeta('motif');
  @override
  late final GeneratedColumn<String> motif = GeneratedColumn<String>(
    'motif',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creeLeMeta = const VerificationMeta('creeLe');
  @override
  late final GeneratedColumn<DateTime> creeLe = GeneratedColumn<DateTime>(
    'cree_le',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saisieManuelleMeta = const VerificationMeta(
    'saisieManuelle',
  );
  @override
  late final GeneratedColumn<bool> saisieManuelle = GeneratedColumn<bool>(
    'saisie_manuelle',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("saisie_manuelle" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    campagneId,
    numeroInventaire,
    pieceId,
    serviceId,
    serviceLocalId,
    responsable,
    etat,
    commentaire,
    photoLocale,
    photoUrl,
    scanneLe,
    statut,
    motif,
    creeLe,
    saisieManuelle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scans_locaux';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScansLocauxData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('campagne_id')) {
      context.handle(
        _campagneIdMeta,
        campagneId.isAcceptableOrUnknown(data['campagne_id']!, _campagneIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campagneIdMeta);
    }
    if (data.containsKey('numero_inventaire')) {
      context.handle(
        _numeroInventaireMeta,
        numeroInventaire.isAcceptableOrUnknown(
          data['numero_inventaire']!,
          _numeroInventaireMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numeroInventaireMeta);
    }
    if (data.containsKey('piece_id')) {
      context.handle(
        _pieceIdMeta,
        pieceId.isAcceptableOrUnknown(data['piece_id']!, _pieceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pieceIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    }
    if (data.containsKey('service_local_id')) {
      context.handle(
        _serviceLocalIdMeta,
        serviceLocalId.isAcceptableOrUnknown(
          data['service_local_id']!,
          _serviceLocalIdMeta,
        ),
      );
    }
    if (data.containsKey('responsable')) {
      context.handle(
        _responsableMeta,
        responsable.isAcceptableOrUnknown(
          data['responsable']!,
          _responsableMeta,
        ),
      );
    }
    if (data.containsKey('etat')) {
      context.handle(
        _etatMeta,
        etat.isAcceptableOrUnknown(data['etat']!, _etatMeta),
      );
    } else if (isInserting) {
      context.missing(_etatMeta);
    }
    if (data.containsKey('commentaire')) {
      context.handle(
        _commentaireMeta,
        commentaire.isAcceptableOrUnknown(
          data['commentaire']!,
          _commentaireMeta,
        ),
      );
    }
    if (data.containsKey('photo_locale')) {
      context.handle(
        _photoLocaleMeta,
        photoLocale.isAcceptableOrUnknown(
          data['photo_locale']!,
          _photoLocaleMeta,
        ),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('scanne_le')) {
      context.handle(
        _scanneLeMeta,
        scanneLe.isAcceptableOrUnknown(data['scanne_le']!, _scanneLeMeta),
      );
    } else if (isInserting) {
      context.missing(_scanneLeMeta);
    }
    if (data.containsKey('statut')) {
      context.handle(
        _statutMeta,
        statut.isAcceptableOrUnknown(data['statut']!, _statutMeta),
      );
    }
    if (data.containsKey('motif')) {
      context.handle(
        _motifMeta,
        motif.isAcceptableOrUnknown(data['motif']!, _motifMeta),
      );
    }
    if (data.containsKey('cree_le')) {
      context.handle(
        _creeLeMeta,
        creeLe.isAcceptableOrUnknown(data['cree_le']!, _creeLeMeta),
      );
    } else if (isInserting) {
      context.missing(_creeLeMeta);
    }
    if (data.containsKey('saisie_manuelle')) {
      context.handle(
        _saisieManuelleMeta,
        saisieManuelle.isAcceptableOrUnknown(
          data['saisie_manuelle']!,
          _saisieManuelleMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScansLocauxData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScansLocauxData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      campagneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campagne_id'],
      )!,
      numeroInventaire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_inventaire'],
      )!,
      pieceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}piece_id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      ),
      serviceLocalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_local_id'],
      ),
      responsable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}responsable'],
      ),
      etat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}etat'],
      )!,
      commentaire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}commentaire'],
      ),
      photoLocale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_locale'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      scanneLe: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanne_le'],
      )!,
      statut: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}statut'],
      )!,
      motif: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motif'],
      ),
      creeLe: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cree_le'],
      )!,
      saisieManuelle: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}saisie_manuelle'],
      )!,
    );
  }

  @override
  $ScansLocauxTable createAlias(String alias) {
    return $ScansLocauxTable(attachedDatabase, alias);
  }
}

class ScansLocauxData extends DataClass implements Insertable<ScansLocauxData> {
  final String id;
  final String campagneId;
  final String numeroInventaire;
  final String pieceId;
  final String? serviceId;
  final String? serviceLocalId;
  final String? responsable;
  final String etat;
  final String? commentaire;
  final String? photoLocale;
  final String? photoUrl;
  final DateTime scanneLe;
  final String statut;
  final String? motif;
  final DateTime creeLe;
  final bool saisieManuelle;
  const ScansLocauxData({
    required this.id,
    required this.campagneId,
    required this.numeroInventaire,
    required this.pieceId,
    this.serviceId,
    this.serviceLocalId,
    this.responsable,
    required this.etat,
    this.commentaire,
    this.photoLocale,
    this.photoUrl,
    required this.scanneLe,
    required this.statut,
    this.motif,
    required this.creeLe,
    required this.saisieManuelle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['campagne_id'] = Variable<String>(campagneId);
    map['numero_inventaire'] = Variable<String>(numeroInventaire);
    map['piece_id'] = Variable<String>(pieceId);
    if (!nullToAbsent || serviceId != null) {
      map['service_id'] = Variable<String>(serviceId);
    }
    if (!nullToAbsent || serviceLocalId != null) {
      map['service_local_id'] = Variable<String>(serviceLocalId);
    }
    if (!nullToAbsent || responsable != null) {
      map['responsable'] = Variable<String>(responsable);
    }
    map['etat'] = Variable<String>(etat);
    if (!nullToAbsent || commentaire != null) {
      map['commentaire'] = Variable<String>(commentaire);
    }
    if (!nullToAbsent || photoLocale != null) {
      map['photo_locale'] = Variable<String>(photoLocale);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['scanne_le'] = Variable<DateTime>(scanneLe);
    map['statut'] = Variable<String>(statut);
    if (!nullToAbsent || motif != null) {
      map['motif'] = Variable<String>(motif);
    }
    map['cree_le'] = Variable<DateTime>(creeLe);
    map['saisie_manuelle'] = Variable<bool>(saisieManuelle);
    return map;
  }

  ScansLocauxCompanion toCompanion(bool nullToAbsent) {
    return ScansLocauxCompanion(
      id: Value(id),
      campagneId: Value(campagneId),
      numeroInventaire: Value(numeroInventaire),
      pieceId: Value(pieceId),
      serviceId: serviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceId),
      serviceLocalId: serviceLocalId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceLocalId),
      responsable: responsable == null && nullToAbsent
          ? const Value.absent()
          : Value(responsable),
      etat: Value(etat),
      commentaire: commentaire == null && nullToAbsent
          ? const Value.absent()
          : Value(commentaire),
      photoLocale: photoLocale == null && nullToAbsent
          ? const Value.absent()
          : Value(photoLocale),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      scanneLe: Value(scanneLe),
      statut: Value(statut),
      motif: motif == null && nullToAbsent
          ? const Value.absent()
          : Value(motif),
      creeLe: Value(creeLe),
      saisieManuelle: Value(saisieManuelle),
    );
  }

  factory ScansLocauxData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScansLocauxData(
      id: serializer.fromJson<String>(json['id']),
      campagneId: serializer.fromJson<String>(json['campagneId']),
      numeroInventaire: serializer.fromJson<String>(json['numeroInventaire']),
      pieceId: serializer.fromJson<String>(json['pieceId']),
      serviceId: serializer.fromJson<String?>(json['serviceId']),
      serviceLocalId: serializer.fromJson<String?>(json['serviceLocalId']),
      responsable: serializer.fromJson<String?>(json['responsable']),
      etat: serializer.fromJson<String>(json['etat']),
      commentaire: serializer.fromJson<String?>(json['commentaire']),
      photoLocale: serializer.fromJson<String?>(json['photoLocale']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      scanneLe: serializer.fromJson<DateTime>(json['scanneLe']),
      statut: serializer.fromJson<String>(json['statut']),
      motif: serializer.fromJson<String?>(json['motif']),
      creeLe: serializer.fromJson<DateTime>(json['creeLe']),
      saisieManuelle: serializer.fromJson<bool>(json['saisieManuelle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'campagneId': serializer.toJson<String>(campagneId),
      'numeroInventaire': serializer.toJson<String>(numeroInventaire),
      'pieceId': serializer.toJson<String>(pieceId),
      'serviceId': serializer.toJson<String?>(serviceId),
      'serviceLocalId': serializer.toJson<String?>(serviceLocalId),
      'responsable': serializer.toJson<String?>(responsable),
      'etat': serializer.toJson<String>(etat),
      'commentaire': serializer.toJson<String?>(commentaire),
      'photoLocale': serializer.toJson<String?>(photoLocale),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'scanneLe': serializer.toJson<DateTime>(scanneLe),
      'statut': serializer.toJson<String>(statut),
      'motif': serializer.toJson<String?>(motif),
      'creeLe': serializer.toJson<DateTime>(creeLe),
      'saisieManuelle': serializer.toJson<bool>(saisieManuelle),
    };
  }

  ScansLocauxData copyWith({
    String? id,
    String? campagneId,
    String? numeroInventaire,
    String? pieceId,
    Value<String?> serviceId = const Value.absent(),
    Value<String?> serviceLocalId = const Value.absent(),
    Value<String?> responsable = const Value.absent(),
    String? etat,
    Value<String?> commentaire = const Value.absent(),
    Value<String?> photoLocale = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? scanneLe,
    String? statut,
    Value<String?> motif = const Value.absent(),
    DateTime? creeLe,
    bool? saisieManuelle,
  }) => ScansLocauxData(
    id: id ?? this.id,
    campagneId: campagneId ?? this.campagneId,
    numeroInventaire: numeroInventaire ?? this.numeroInventaire,
    pieceId: pieceId ?? this.pieceId,
    serviceId: serviceId.present ? serviceId.value : this.serviceId,
    serviceLocalId: serviceLocalId.present
        ? serviceLocalId.value
        : this.serviceLocalId,
    responsable: responsable.present ? responsable.value : this.responsable,
    etat: etat ?? this.etat,
    commentaire: commentaire.present ? commentaire.value : this.commentaire,
    photoLocale: photoLocale.present ? photoLocale.value : this.photoLocale,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    scanneLe: scanneLe ?? this.scanneLe,
    statut: statut ?? this.statut,
    motif: motif.present ? motif.value : this.motif,
    creeLe: creeLe ?? this.creeLe,
    saisieManuelle: saisieManuelle ?? this.saisieManuelle,
  );
  ScansLocauxData copyWithCompanion(ScansLocauxCompanion data) {
    return ScansLocauxData(
      id: data.id.present ? data.id.value : this.id,
      campagneId: data.campagneId.present
          ? data.campagneId.value
          : this.campagneId,
      numeroInventaire: data.numeroInventaire.present
          ? data.numeroInventaire.value
          : this.numeroInventaire,
      pieceId: data.pieceId.present ? data.pieceId.value : this.pieceId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      serviceLocalId: data.serviceLocalId.present
          ? data.serviceLocalId.value
          : this.serviceLocalId,
      responsable: data.responsable.present
          ? data.responsable.value
          : this.responsable,
      etat: data.etat.present ? data.etat.value : this.etat,
      commentaire: data.commentaire.present
          ? data.commentaire.value
          : this.commentaire,
      photoLocale: data.photoLocale.present
          ? data.photoLocale.value
          : this.photoLocale,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      scanneLe: data.scanneLe.present ? data.scanneLe.value : this.scanneLe,
      statut: data.statut.present ? data.statut.value : this.statut,
      motif: data.motif.present ? data.motif.value : this.motif,
      creeLe: data.creeLe.present ? data.creeLe.value : this.creeLe,
      saisieManuelle: data.saisieManuelle.present
          ? data.saisieManuelle.value
          : this.saisieManuelle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScansLocauxData(')
          ..write('id: $id, ')
          ..write('campagneId: $campagneId, ')
          ..write('numeroInventaire: $numeroInventaire, ')
          ..write('pieceId: $pieceId, ')
          ..write('serviceId: $serviceId, ')
          ..write('serviceLocalId: $serviceLocalId, ')
          ..write('responsable: $responsable, ')
          ..write('etat: $etat, ')
          ..write('commentaire: $commentaire, ')
          ..write('photoLocale: $photoLocale, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('scanneLe: $scanneLe, ')
          ..write('statut: $statut, ')
          ..write('motif: $motif, ')
          ..write('creeLe: $creeLe, ')
          ..write('saisieManuelle: $saisieManuelle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    campagneId,
    numeroInventaire,
    pieceId,
    serviceId,
    serviceLocalId,
    responsable,
    etat,
    commentaire,
    photoLocale,
    photoUrl,
    scanneLe,
    statut,
    motif,
    creeLe,
    saisieManuelle,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScansLocauxData &&
          other.id == this.id &&
          other.campagneId == this.campagneId &&
          other.numeroInventaire == this.numeroInventaire &&
          other.pieceId == this.pieceId &&
          other.serviceId == this.serviceId &&
          other.serviceLocalId == this.serviceLocalId &&
          other.responsable == this.responsable &&
          other.etat == this.etat &&
          other.commentaire == this.commentaire &&
          other.photoLocale == this.photoLocale &&
          other.photoUrl == this.photoUrl &&
          other.scanneLe == this.scanneLe &&
          other.statut == this.statut &&
          other.motif == this.motif &&
          other.creeLe == this.creeLe &&
          other.saisieManuelle == this.saisieManuelle);
}

class ScansLocauxCompanion extends UpdateCompanion<ScansLocauxData> {
  final Value<String> id;
  final Value<String> campagneId;
  final Value<String> numeroInventaire;
  final Value<String> pieceId;
  final Value<String?> serviceId;
  final Value<String?> serviceLocalId;
  final Value<String?> responsable;
  final Value<String> etat;
  final Value<String?> commentaire;
  final Value<String?> photoLocale;
  final Value<String?> photoUrl;
  final Value<DateTime> scanneLe;
  final Value<String> statut;
  final Value<String?> motif;
  final Value<DateTime> creeLe;
  final Value<bool> saisieManuelle;
  final Value<int> rowid;
  const ScansLocauxCompanion({
    this.id = const Value.absent(),
    this.campagneId = const Value.absent(),
    this.numeroInventaire = const Value.absent(),
    this.pieceId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.serviceLocalId = const Value.absent(),
    this.responsable = const Value.absent(),
    this.etat = const Value.absent(),
    this.commentaire = const Value.absent(),
    this.photoLocale = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.scanneLe = const Value.absent(),
    this.statut = const Value.absent(),
    this.motif = const Value.absent(),
    this.creeLe = const Value.absent(),
    this.saisieManuelle = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScansLocauxCompanion.insert({
    required String id,
    required String campagneId,
    required String numeroInventaire,
    required String pieceId,
    this.serviceId = const Value.absent(),
    this.serviceLocalId = const Value.absent(),
    this.responsable = const Value.absent(),
    required String etat,
    this.commentaire = const Value.absent(),
    this.photoLocale = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required DateTime scanneLe,
    this.statut = const Value.absent(),
    this.motif = const Value.absent(),
    required DateTime creeLe,
    this.saisieManuelle = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       campagneId = Value(campagneId),
       numeroInventaire = Value(numeroInventaire),
       pieceId = Value(pieceId),
       etat = Value(etat),
       scanneLe = Value(scanneLe),
       creeLe = Value(creeLe);
  static Insertable<ScansLocauxData> custom({
    Expression<String>? id,
    Expression<String>? campagneId,
    Expression<String>? numeroInventaire,
    Expression<String>? pieceId,
    Expression<String>? serviceId,
    Expression<String>? serviceLocalId,
    Expression<String>? responsable,
    Expression<String>? etat,
    Expression<String>? commentaire,
    Expression<String>? photoLocale,
    Expression<String>? photoUrl,
    Expression<DateTime>? scanneLe,
    Expression<String>? statut,
    Expression<String>? motif,
    Expression<DateTime>? creeLe,
    Expression<bool>? saisieManuelle,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campagneId != null) 'campagne_id': campagneId,
      if (numeroInventaire != null) 'numero_inventaire': numeroInventaire,
      if (pieceId != null) 'piece_id': pieceId,
      if (serviceId != null) 'service_id': serviceId,
      if (serviceLocalId != null) 'service_local_id': serviceLocalId,
      if (responsable != null) 'responsable': responsable,
      if (etat != null) 'etat': etat,
      if (commentaire != null) 'commentaire': commentaire,
      if (photoLocale != null) 'photo_locale': photoLocale,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (scanneLe != null) 'scanne_le': scanneLe,
      if (statut != null) 'statut': statut,
      if (motif != null) 'motif': motif,
      if (creeLe != null) 'cree_le': creeLe,
      if (saisieManuelle != null) 'saisie_manuelle': saisieManuelle,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScansLocauxCompanion copyWith({
    Value<String>? id,
    Value<String>? campagneId,
    Value<String>? numeroInventaire,
    Value<String>? pieceId,
    Value<String?>? serviceId,
    Value<String?>? serviceLocalId,
    Value<String?>? responsable,
    Value<String>? etat,
    Value<String?>? commentaire,
    Value<String?>? photoLocale,
    Value<String?>? photoUrl,
    Value<DateTime>? scanneLe,
    Value<String>? statut,
    Value<String?>? motif,
    Value<DateTime>? creeLe,
    Value<bool>? saisieManuelle,
    Value<int>? rowid,
  }) {
    return ScansLocauxCompanion(
      id: id ?? this.id,
      campagneId: campagneId ?? this.campagneId,
      numeroInventaire: numeroInventaire ?? this.numeroInventaire,
      pieceId: pieceId ?? this.pieceId,
      serviceId: serviceId ?? this.serviceId,
      serviceLocalId: serviceLocalId ?? this.serviceLocalId,
      responsable: responsable ?? this.responsable,
      etat: etat ?? this.etat,
      commentaire: commentaire ?? this.commentaire,
      photoLocale: photoLocale ?? this.photoLocale,
      photoUrl: photoUrl ?? this.photoUrl,
      scanneLe: scanneLe ?? this.scanneLe,
      statut: statut ?? this.statut,
      motif: motif ?? this.motif,
      creeLe: creeLe ?? this.creeLe,
      saisieManuelle: saisieManuelle ?? this.saisieManuelle,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (campagneId.present) {
      map['campagne_id'] = Variable<String>(campagneId.value);
    }
    if (numeroInventaire.present) {
      map['numero_inventaire'] = Variable<String>(numeroInventaire.value);
    }
    if (pieceId.present) {
      map['piece_id'] = Variable<String>(pieceId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (serviceLocalId.present) {
      map['service_local_id'] = Variable<String>(serviceLocalId.value);
    }
    if (responsable.present) {
      map['responsable'] = Variable<String>(responsable.value);
    }
    if (etat.present) {
      map['etat'] = Variable<String>(etat.value);
    }
    if (commentaire.present) {
      map['commentaire'] = Variable<String>(commentaire.value);
    }
    if (photoLocale.present) {
      map['photo_locale'] = Variable<String>(photoLocale.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (scanneLe.present) {
      map['scanne_le'] = Variable<DateTime>(scanneLe.value);
    }
    if (statut.present) {
      map['statut'] = Variable<String>(statut.value);
    }
    if (motif.present) {
      map['motif'] = Variable<String>(motif.value);
    }
    if (creeLe.present) {
      map['cree_le'] = Variable<DateTime>(creeLe.value);
    }
    if (saisieManuelle.present) {
      map['saisie_manuelle'] = Variable<bool>(saisieManuelle.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScansLocauxCompanion(')
          ..write('id: $id, ')
          ..write('campagneId: $campagneId, ')
          ..write('numeroInventaire: $numeroInventaire, ')
          ..write('pieceId: $pieceId, ')
          ..write('serviceId: $serviceId, ')
          ..write('serviceLocalId: $serviceLocalId, ')
          ..write('responsable: $responsable, ')
          ..write('etat: $etat, ')
          ..write('commentaire: $commentaire, ')
          ..write('photoLocale: $photoLocale, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('scanneLe: $scanneLe, ')
          ..write('statut: $statut, ')
          ..write('motif: $motif, ')
          ..write('creeLe: $creeLe, ')
          ..write('saisieManuelle: $saisieManuelle, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetaTable extends Meta with TableInfo<$MetaTable, MetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cleMeta = const VerificationMeta('cle');
  @override
  late final GeneratedColumn<String> cle = GeneratedColumn<String>(
    'cle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valeurMeta = const VerificationMeta('valeur');
  @override
  late final GeneratedColumn<String> valeur = GeneratedColumn<String>(
    'valeur',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [cle, valeur];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cle')) {
      context.handle(
        _cleMeta,
        cle.isAcceptableOrUnknown(data['cle']!, _cleMeta),
      );
    } else if (isInserting) {
      context.missing(_cleMeta);
    }
    if (data.containsKey('valeur')) {
      context.handle(
        _valeurMeta,
        valeur.isAcceptableOrUnknown(data['valeur']!, _valeurMeta),
      );
    } else if (isInserting) {
      context.missing(_valeurMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cle};
  @override
  MetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaData(
      cle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cle'],
      )!,
      valeur: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valeur'],
      )!,
    );
  }

  @override
  $MetaTable createAlias(String alias) {
    return $MetaTable(attachedDatabase, alias);
  }
}

class MetaData extends DataClass implements Insertable<MetaData> {
  final String cle;
  final String valeur;
  const MetaData({required this.cle, required this.valeur});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cle'] = Variable<String>(cle);
    map['valeur'] = Variable<String>(valeur);
    return map;
  }

  MetaCompanion toCompanion(bool nullToAbsent) {
    return MetaCompanion(cle: Value(cle), valeur: Value(valeur));
  }

  factory MetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaData(
      cle: serializer.fromJson<String>(json['cle']),
      valeur: serializer.fromJson<String>(json['valeur']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cle': serializer.toJson<String>(cle),
      'valeur': serializer.toJson<String>(valeur),
    };
  }

  MetaData copyWith({String? cle, String? valeur}) =>
      MetaData(cle: cle ?? this.cle, valeur: valeur ?? this.valeur);
  MetaData copyWithCompanion(MetaCompanion data) {
    return MetaData(
      cle: data.cle.present ? data.cle.value : this.cle,
      valeur: data.valeur.present ? data.valeur.value : this.valeur,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaData(')
          ..write('cle: $cle, ')
          ..write('valeur: $valeur')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cle, valeur);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaData &&
          other.cle == this.cle &&
          other.valeur == this.valeur);
}

class MetaCompanion extends UpdateCompanion<MetaData> {
  final Value<String> cle;
  final Value<String> valeur;
  final Value<int> rowid;
  const MetaCompanion({
    this.cle = const Value.absent(),
    this.valeur = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaCompanion.insert({
    required String cle,
    required String valeur,
    this.rowid = const Value.absent(),
  }) : cle = Value(cle),
       valeur = Value(valeur);
  static Insertable<MetaData> custom({
    Expression<String>? cle,
    Expression<String>? valeur,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cle != null) 'cle': cle,
      if (valeur != null) 'valeur': valeur,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaCompanion copyWith({
    Value<String>? cle,
    Value<String>? valeur,
    Value<int>? rowid,
  }) {
    return MetaCompanion(
      cle: cle ?? this.cle,
      valeur: valeur ?? this.valeur,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cle.present) {
      map['cle'] = Variable<String>(cle.value);
    }
    if (valeur.present) {
      map['valeur'] = Variable<String>(valeur.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaCompanion(')
          ..write('cle: $cle, ')
          ..write('valeur: $valeur, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScansCampagneTable extends ScansCampagne
    with TableInfo<$ScansCampagneTable, ScansCampagneData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScansCampagneTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _campagneIdMeta = const VerificationMeta(
    'campagneId',
  );
  @override
  late final GeneratedColumn<String> campagneId = GeneratedColumn<String>(
    'campagne_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bienIdMeta = const VerificationMeta('bienId');
  @override
  late final GeneratedColumn<String> bienId = GeneratedColumn<String>(
    'bien_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroMeta = const VerificationMeta('numero');
  @override
  late final GeneratedColumn<String> numero = GeneratedColumn<String>(
    'numero',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scanneLeMeta = const VerificationMeta(
    'scanneLe',
  );
  @override
  late final GeneratedColumn<DateTime> scanneLe = GeneratedColumn<DateTime>(
    'scanne_le',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agentNomMeta = const VerificationMeta(
    'agentNom',
  );
  @override
  late final GeneratedColumn<String> agentNom = GeneratedColumn<String>(
    'agent_nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pieceCodeMeta = const VerificationMeta(
    'pieceCode',
  );
  @override
  late final GeneratedColumn<String> pieceCode = GeneratedColumn<String>(
    'piece_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    campagneId,
    bienId,
    numero,
    scanneLe,
    agentNom,
    pieceCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scans_campagne';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScansCampagneData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('campagne_id')) {
      context.handle(
        _campagneIdMeta,
        campagneId.isAcceptableOrUnknown(data['campagne_id']!, _campagneIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campagneIdMeta);
    }
    if (data.containsKey('bien_id')) {
      context.handle(
        _bienIdMeta,
        bienId.isAcceptableOrUnknown(data['bien_id']!, _bienIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bienIdMeta);
    }
    if (data.containsKey('numero')) {
      context.handle(
        _numeroMeta,
        numero.isAcceptableOrUnknown(data['numero']!, _numeroMeta),
      );
    } else if (isInserting) {
      context.missing(_numeroMeta);
    }
    if (data.containsKey('scanne_le')) {
      context.handle(
        _scanneLeMeta,
        scanneLe.isAcceptableOrUnknown(data['scanne_le']!, _scanneLeMeta),
      );
    } else if (isInserting) {
      context.missing(_scanneLeMeta);
    }
    if (data.containsKey('agent_nom')) {
      context.handle(
        _agentNomMeta,
        agentNom.isAcceptableOrUnknown(data['agent_nom']!, _agentNomMeta),
      );
    } else if (isInserting) {
      context.missing(_agentNomMeta);
    }
    if (data.containsKey('piece_code')) {
      context.handle(
        _pieceCodeMeta,
        pieceCode.isAcceptableOrUnknown(data['piece_code']!, _pieceCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_pieceCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {campagneId, bienId};
  @override
  ScansCampagneData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScansCampagneData(
      campagneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campagne_id'],
      )!,
      bienId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bien_id'],
      )!,
      numero: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero'],
      )!,
      scanneLe: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanne_le'],
      )!,
      agentNom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}agent_nom'],
      )!,
      pieceCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}piece_code'],
      )!,
    );
  }

  @override
  $ScansCampagneTable createAlias(String alias) {
    return $ScansCampagneTable(attachedDatabase, alias);
  }
}

class ScansCampagneData extends DataClass
    implements Insertable<ScansCampagneData> {
  final String campagneId;
  final String bienId;
  final String numero;
  final DateTime scanneLe;
  final String agentNom;
  final String pieceCode;
  const ScansCampagneData({
    required this.campagneId,
    required this.bienId,
    required this.numero,
    required this.scanneLe,
    required this.agentNom,
    required this.pieceCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['campagne_id'] = Variable<String>(campagneId);
    map['bien_id'] = Variable<String>(bienId);
    map['numero'] = Variable<String>(numero);
    map['scanne_le'] = Variable<DateTime>(scanneLe);
    map['agent_nom'] = Variable<String>(agentNom);
    map['piece_code'] = Variable<String>(pieceCode);
    return map;
  }

  ScansCampagneCompanion toCompanion(bool nullToAbsent) {
    return ScansCampagneCompanion(
      campagneId: Value(campagneId),
      bienId: Value(bienId),
      numero: Value(numero),
      scanneLe: Value(scanneLe),
      agentNom: Value(agentNom),
      pieceCode: Value(pieceCode),
    );
  }

  factory ScansCampagneData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScansCampagneData(
      campagneId: serializer.fromJson<String>(json['campagneId']),
      bienId: serializer.fromJson<String>(json['bienId']),
      numero: serializer.fromJson<String>(json['numero']),
      scanneLe: serializer.fromJson<DateTime>(json['scanneLe']),
      agentNom: serializer.fromJson<String>(json['agentNom']),
      pieceCode: serializer.fromJson<String>(json['pieceCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'campagneId': serializer.toJson<String>(campagneId),
      'bienId': serializer.toJson<String>(bienId),
      'numero': serializer.toJson<String>(numero),
      'scanneLe': serializer.toJson<DateTime>(scanneLe),
      'agentNom': serializer.toJson<String>(agentNom),
      'pieceCode': serializer.toJson<String>(pieceCode),
    };
  }

  ScansCampagneData copyWith({
    String? campagneId,
    String? bienId,
    String? numero,
    DateTime? scanneLe,
    String? agentNom,
    String? pieceCode,
  }) => ScansCampagneData(
    campagneId: campagneId ?? this.campagneId,
    bienId: bienId ?? this.bienId,
    numero: numero ?? this.numero,
    scanneLe: scanneLe ?? this.scanneLe,
    agentNom: agentNom ?? this.agentNom,
    pieceCode: pieceCode ?? this.pieceCode,
  );
  ScansCampagneData copyWithCompanion(ScansCampagneCompanion data) {
    return ScansCampagneData(
      campagneId: data.campagneId.present
          ? data.campagneId.value
          : this.campagneId,
      bienId: data.bienId.present ? data.bienId.value : this.bienId,
      numero: data.numero.present ? data.numero.value : this.numero,
      scanneLe: data.scanneLe.present ? data.scanneLe.value : this.scanneLe,
      agentNom: data.agentNom.present ? data.agentNom.value : this.agentNom,
      pieceCode: data.pieceCode.present ? data.pieceCode.value : this.pieceCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScansCampagneData(')
          ..write('campagneId: $campagneId, ')
          ..write('bienId: $bienId, ')
          ..write('numero: $numero, ')
          ..write('scanneLe: $scanneLe, ')
          ..write('agentNom: $agentNom, ')
          ..write('pieceCode: $pieceCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(campagneId, bienId, numero, scanneLe, agentNom, pieceCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScansCampagneData &&
          other.campagneId == this.campagneId &&
          other.bienId == this.bienId &&
          other.numero == this.numero &&
          other.scanneLe == this.scanneLe &&
          other.agentNom == this.agentNom &&
          other.pieceCode == this.pieceCode);
}

class ScansCampagneCompanion extends UpdateCompanion<ScansCampagneData> {
  final Value<String> campagneId;
  final Value<String> bienId;
  final Value<String> numero;
  final Value<DateTime> scanneLe;
  final Value<String> agentNom;
  final Value<String> pieceCode;
  final Value<int> rowid;
  const ScansCampagneCompanion({
    this.campagneId = const Value.absent(),
    this.bienId = const Value.absent(),
    this.numero = const Value.absent(),
    this.scanneLe = const Value.absent(),
    this.agentNom = const Value.absent(),
    this.pieceCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScansCampagneCompanion.insert({
    required String campagneId,
    required String bienId,
    required String numero,
    required DateTime scanneLe,
    required String agentNom,
    required String pieceCode,
    this.rowid = const Value.absent(),
  }) : campagneId = Value(campagneId),
       bienId = Value(bienId),
       numero = Value(numero),
       scanneLe = Value(scanneLe),
       agentNom = Value(agentNom),
       pieceCode = Value(pieceCode);
  static Insertable<ScansCampagneData> custom({
    Expression<String>? campagneId,
    Expression<String>? bienId,
    Expression<String>? numero,
    Expression<DateTime>? scanneLe,
    Expression<String>? agentNom,
    Expression<String>? pieceCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (campagneId != null) 'campagne_id': campagneId,
      if (bienId != null) 'bien_id': bienId,
      if (numero != null) 'numero': numero,
      if (scanneLe != null) 'scanne_le': scanneLe,
      if (agentNom != null) 'agent_nom': agentNom,
      if (pieceCode != null) 'piece_code': pieceCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScansCampagneCompanion copyWith({
    Value<String>? campagneId,
    Value<String>? bienId,
    Value<String>? numero,
    Value<DateTime>? scanneLe,
    Value<String>? agentNom,
    Value<String>? pieceCode,
    Value<int>? rowid,
  }) {
    return ScansCampagneCompanion(
      campagneId: campagneId ?? this.campagneId,
      bienId: bienId ?? this.bienId,
      numero: numero ?? this.numero,
      scanneLe: scanneLe ?? this.scanneLe,
      agentNom: agentNom ?? this.agentNom,
      pieceCode: pieceCode ?? this.pieceCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (campagneId.present) {
      map['campagne_id'] = Variable<String>(campagneId.value);
    }
    if (bienId.present) {
      map['bien_id'] = Variable<String>(bienId.value);
    }
    if (numero.present) {
      map['numero'] = Variable<String>(numero.value);
    }
    if (scanneLe.present) {
      map['scanne_le'] = Variable<DateTime>(scanneLe.value);
    }
    if (agentNom.present) {
      map['agent_nom'] = Variable<String>(agentNom.value);
    }
    if (pieceCode.present) {
      map['piece_code'] = Variable<String>(pieceCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScansCampagneCompanion(')
          ..write('campagneId: $campagneId, ')
          ..write('bienId: $bienId, ')
          ..write('numero: $numero, ')
          ..write('scanneLe: $scanneLe, ')
          ..write('agentNom: $agentNom, ')
          ..write('pieceCode: $pieceCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AffectationsCacheTable extends AffectationsCache
    with TableInfo<$AffectationsCacheTable, AffectationsCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AffectationsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _campagneIdMeta = const VerificationMeta(
    'campagneId',
  );
  @override
  late final GeneratedColumn<String> campagneId = GeneratedColumn<String>(
    'campagne_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lieuIdMeta = const VerificationMeta('lieuId');
  @override
  late final GeneratedColumn<String> lieuId = GeneratedColumn<String>(
    'lieu_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lieuNomMeta = const VerificationMeta(
    'lieuNom',
  );
  @override
  late final GeneratedColumn<String> lieuNom = GeneratedColumn<String>(
    'lieu_nom',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pieceIdMeta = const VerificationMeta(
    'pieceId',
  );
  @override
  late final GeneratedColumn<String> pieceId = GeneratedColumn<String>(
    'piece_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pieceCodeMeta = const VerificationMeta(
    'pieceCode',
  );
  @override
  late final GeneratedColumn<String> pieceCode = GeneratedColumn<String>(
    'piece_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pieceLibelleMeta = const VerificationMeta(
    'pieceLibelle',
  );
  @override
  late final GeneratedColumn<String> pieceLibelle = GeneratedColumn<String>(
    'piece_libelle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _piecesAffecteesMeta = const VerificationMeta(
    'piecesAffectees',
  );
  @override
  late final GeneratedColumn<int> piecesAffectees = GeneratedColumn<int>(
    'pieces_affectees',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _piecesScanneesMeta = const VerificationMeta(
    'piecesScannees',
  );
  @override
  late final GeneratedColumn<int> piecesScannees = GeneratedColumn<int>(
    'pieces_scannees',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nbScansMeta = const VerificationMeta(
    'nbScans',
  );
  @override
  late final GeneratedColumn<int> nbScans = GeneratedColumn<int>(
    'nb_scans',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    campagneId,
    type,
    lieuId,
    lieuNom,
    pieceId,
    pieceCode,
    pieceLibelle,
    serviceId,
    piecesAffectees,
    piecesScannees,
    nbScans,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'affectations_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<AffectationsCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('campagne_id')) {
      context.handle(
        _campagneIdMeta,
        campagneId.isAcceptableOrUnknown(data['campagne_id']!, _campagneIdMeta),
      );
    } else if (isInserting) {
      context.missing(_campagneIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('lieu_id')) {
      context.handle(
        _lieuIdMeta,
        lieuId.isAcceptableOrUnknown(data['lieu_id']!, _lieuIdMeta),
      );
    }
    if (data.containsKey('lieu_nom')) {
      context.handle(
        _lieuNomMeta,
        lieuNom.isAcceptableOrUnknown(data['lieu_nom']!, _lieuNomMeta),
      );
    }
    if (data.containsKey('piece_id')) {
      context.handle(
        _pieceIdMeta,
        pieceId.isAcceptableOrUnknown(data['piece_id']!, _pieceIdMeta),
      );
    }
    if (data.containsKey('piece_code')) {
      context.handle(
        _pieceCodeMeta,
        pieceCode.isAcceptableOrUnknown(data['piece_code']!, _pieceCodeMeta),
      );
    }
    if (data.containsKey('piece_libelle')) {
      context.handle(
        _pieceLibelleMeta,
        pieceLibelle.isAcceptableOrUnknown(
          data['piece_libelle']!,
          _pieceLibelleMeta,
        ),
      );
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    }
    if (data.containsKey('pieces_affectees')) {
      context.handle(
        _piecesAffecteesMeta,
        piecesAffectees.isAcceptableOrUnknown(
          data['pieces_affectees']!,
          _piecesAffecteesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_piecesAffecteesMeta);
    }
    if (data.containsKey('pieces_scannees')) {
      context.handle(
        _piecesScanneesMeta,
        piecesScannees.isAcceptableOrUnknown(
          data['pieces_scannees']!,
          _piecesScanneesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_piecesScanneesMeta);
    }
    if (data.containsKey('nb_scans')) {
      context.handle(
        _nbScansMeta,
        nbScans.isAcceptableOrUnknown(data['nb_scans']!, _nbScansMeta),
      );
    } else if (isInserting) {
      context.missing(_nbScansMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AffectationsCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AffectationsCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      campagneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campagne_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      lieuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lieu_id'],
      ),
      lieuNom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lieu_nom'],
      ),
      pieceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}piece_id'],
      ),
      pieceCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}piece_code'],
      ),
      pieceLibelle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}piece_libelle'],
      ),
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      ),
      piecesAffectees: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pieces_affectees'],
      )!,
      piecesScannees: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pieces_scannees'],
      )!,
      nbScans: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nb_scans'],
      )!,
    );
  }

  @override
  $AffectationsCacheTable createAlias(String alias) {
    return $AffectationsCacheTable(attachedDatabase, alias);
  }
}

class AffectationsCacheData extends DataClass
    implements Insertable<AffectationsCacheData> {
  final String id;
  final String campagneId;
  final String type;
  final String? lieuId;
  final String? lieuNom;
  final String? pieceId;
  final String? pieceCode;
  final String? pieceLibelle;
  final String? serviceId;
  final int piecesAffectees;
  final int piecesScannees;
  final int nbScans;
  const AffectationsCacheData({
    required this.id,
    required this.campagneId,
    required this.type,
    this.lieuId,
    this.lieuNom,
    this.pieceId,
    this.pieceCode,
    this.pieceLibelle,
    this.serviceId,
    required this.piecesAffectees,
    required this.piecesScannees,
    required this.nbScans,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['campagne_id'] = Variable<String>(campagneId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || lieuId != null) {
      map['lieu_id'] = Variable<String>(lieuId);
    }
    if (!nullToAbsent || lieuNom != null) {
      map['lieu_nom'] = Variable<String>(lieuNom);
    }
    if (!nullToAbsent || pieceId != null) {
      map['piece_id'] = Variable<String>(pieceId);
    }
    if (!nullToAbsent || pieceCode != null) {
      map['piece_code'] = Variable<String>(pieceCode);
    }
    if (!nullToAbsent || pieceLibelle != null) {
      map['piece_libelle'] = Variable<String>(pieceLibelle);
    }
    if (!nullToAbsent || serviceId != null) {
      map['service_id'] = Variable<String>(serviceId);
    }
    map['pieces_affectees'] = Variable<int>(piecesAffectees);
    map['pieces_scannees'] = Variable<int>(piecesScannees);
    map['nb_scans'] = Variable<int>(nbScans);
    return map;
  }

  AffectationsCacheCompanion toCompanion(bool nullToAbsent) {
    return AffectationsCacheCompanion(
      id: Value(id),
      campagneId: Value(campagneId),
      type: Value(type),
      lieuId: lieuId == null && nullToAbsent
          ? const Value.absent()
          : Value(lieuId),
      lieuNom: lieuNom == null && nullToAbsent
          ? const Value.absent()
          : Value(lieuNom),
      pieceId: pieceId == null && nullToAbsent
          ? const Value.absent()
          : Value(pieceId),
      pieceCode: pieceCode == null && nullToAbsent
          ? const Value.absent()
          : Value(pieceCode),
      pieceLibelle: pieceLibelle == null && nullToAbsent
          ? const Value.absent()
          : Value(pieceLibelle),
      serviceId: serviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceId),
      piecesAffectees: Value(piecesAffectees),
      piecesScannees: Value(piecesScannees),
      nbScans: Value(nbScans),
    );
  }

  factory AffectationsCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AffectationsCacheData(
      id: serializer.fromJson<String>(json['id']),
      campagneId: serializer.fromJson<String>(json['campagneId']),
      type: serializer.fromJson<String>(json['type']),
      lieuId: serializer.fromJson<String?>(json['lieuId']),
      lieuNom: serializer.fromJson<String?>(json['lieuNom']),
      pieceId: serializer.fromJson<String?>(json['pieceId']),
      pieceCode: serializer.fromJson<String?>(json['pieceCode']),
      pieceLibelle: serializer.fromJson<String?>(json['pieceLibelle']),
      serviceId: serializer.fromJson<String?>(json['serviceId']),
      piecesAffectees: serializer.fromJson<int>(json['piecesAffectees']),
      piecesScannees: serializer.fromJson<int>(json['piecesScannees']),
      nbScans: serializer.fromJson<int>(json['nbScans']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'campagneId': serializer.toJson<String>(campagneId),
      'type': serializer.toJson<String>(type),
      'lieuId': serializer.toJson<String?>(lieuId),
      'lieuNom': serializer.toJson<String?>(lieuNom),
      'pieceId': serializer.toJson<String?>(pieceId),
      'pieceCode': serializer.toJson<String?>(pieceCode),
      'pieceLibelle': serializer.toJson<String?>(pieceLibelle),
      'serviceId': serializer.toJson<String?>(serviceId),
      'piecesAffectees': serializer.toJson<int>(piecesAffectees),
      'piecesScannees': serializer.toJson<int>(piecesScannees),
      'nbScans': serializer.toJson<int>(nbScans),
    };
  }

  AffectationsCacheData copyWith({
    String? id,
    String? campagneId,
    String? type,
    Value<String?> lieuId = const Value.absent(),
    Value<String?> lieuNom = const Value.absent(),
    Value<String?> pieceId = const Value.absent(),
    Value<String?> pieceCode = const Value.absent(),
    Value<String?> pieceLibelle = const Value.absent(),
    Value<String?> serviceId = const Value.absent(),
    int? piecesAffectees,
    int? piecesScannees,
    int? nbScans,
  }) => AffectationsCacheData(
    id: id ?? this.id,
    campagneId: campagneId ?? this.campagneId,
    type: type ?? this.type,
    lieuId: lieuId.present ? lieuId.value : this.lieuId,
    lieuNom: lieuNom.present ? lieuNom.value : this.lieuNom,
    pieceId: pieceId.present ? pieceId.value : this.pieceId,
    pieceCode: pieceCode.present ? pieceCode.value : this.pieceCode,
    pieceLibelle: pieceLibelle.present ? pieceLibelle.value : this.pieceLibelle,
    serviceId: serviceId.present ? serviceId.value : this.serviceId,
    piecesAffectees: piecesAffectees ?? this.piecesAffectees,
    piecesScannees: piecesScannees ?? this.piecesScannees,
    nbScans: nbScans ?? this.nbScans,
  );
  AffectationsCacheData copyWithCompanion(AffectationsCacheCompanion data) {
    return AffectationsCacheData(
      id: data.id.present ? data.id.value : this.id,
      campagneId: data.campagneId.present
          ? data.campagneId.value
          : this.campagneId,
      type: data.type.present ? data.type.value : this.type,
      lieuId: data.lieuId.present ? data.lieuId.value : this.lieuId,
      lieuNom: data.lieuNom.present ? data.lieuNom.value : this.lieuNom,
      pieceId: data.pieceId.present ? data.pieceId.value : this.pieceId,
      pieceCode: data.pieceCode.present ? data.pieceCode.value : this.pieceCode,
      pieceLibelle: data.pieceLibelle.present
          ? data.pieceLibelle.value
          : this.pieceLibelle,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      piecesAffectees: data.piecesAffectees.present
          ? data.piecesAffectees.value
          : this.piecesAffectees,
      piecesScannees: data.piecesScannees.present
          ? data.piecesScannees.value
          : this.piecesScannees,
      nbScans: data.nbScans.present ? data.nbScans.value : this.nbScans,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AffectationsCacheData(')
          ..write('id: $id, ')
          ..write('campagneId: $campagneId, ')
          ..write('type: $type, ')
          ..write('lieuId: $lieuId, ')
          ..write('lieuNom: $lieuNom, ')
          ..write('pieceId: $pieceId, ')
          ..write('pieceCode: $pieceCode, ')
          ..write('pieceLibelle: $pieceLibelle, ')
          ..write('serviceId: $serviceId, ')
          ..write('piecesAffectees: $piecesAffectees, ')
          ..write('piecesScannees: $piecesScannees, ')
          ..write('nbScans: $nbScans')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    campagneId,
    type,
    lieuId,
    lieuNom,
    pieceId,
    pieceCode,
    pieceLibelle,
    serviceId,
    piecesAffectees,
    piecesScannees,
    nbScans,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AffectationsCacheData &&
          other.id == this.id &&
          other.campagneId == this.campagneId &&
          other.type == this.type &&
          other.lieuId == this.lieuId &&
          other.lieuNom == this.lieuNom &&
          other.pieceId == this.pieceId &&
          other.pieceCode == this.pieceCode &&
          other.pieceLibelle == this.pieceLibelle &&
          other.serviceId == this.serviceId &&
          other.piecesAffectees == this.piecesAffectees &&
          other.piecesScannees == this.piecesScannees &&
          other.nbScans == this.nbScans);
}

class AffectationsCacheCompanion
    extends UpdateCompanion<AffectationsCacheData> {
  final Value<String> id;
  final Value<String> campagneId;
  final Value<String> type;
  final Value<String?> lieuId;
  final Value<String?> lieuNom;
  final Value<String?> pieceId;
  final Value<String?> pieceCode;
  final Value<String?> pieceLibelle;
  final Value<String?> serviceId;
  final Value<int> piecesAffectees;
  final Value<int> piecesScannees;
  final Value<int> nbScans;
  final Value<int> rowid;
  const AffectationsCacheCompanion({
    this.id = const Value.absent(),
    this.campagneId = const Value.absent(),
    this.type = const Value.absent(),
    this.lieuId = const Value.absent(),
    this.lieuNom = const Value.absent(),
    this.pieceId = const Value.absent(),
    this.pieceCode = const Value.absent(),
    this.pieceLibelle = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.piecesAffectees = const Value.absent(),
    this.piecesScannees = const Value.absent(),
    this.nbScans = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AffectationsCacheCompanion.insert({
    required String id,
    required String campagneId,
    required String type,
    this.lieuId = const Value.absent(),
    this.lieuNom = const Value.absent(),
    this.pieceId = const Value.absent(),
    this.pieceCode = const Value.absent(),
    this.pieceLibelle = const Value.absent(),
    this.serviceId = const Value.absent(),
    required int piecesAffectees,
    required int piecesScannees,
    required int nbScans,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       campagneId = Value(campagneId),
       type = Value(type),
       piecesAffectees = Value(piecesAffectees),
       piecesScannees = Value(piecesScannees),
       nbScans = Value(nbScans);
  static Insertable<AffectationsCacheData> custom({
    Expression<String>? id,
    Expression<String>? campagneId,
    Expression<String>? type,
    Expression<String>? lieuId,
    Expression<String>? lieuNom,
    Expression<String>? pieceId,
    Expression<String>? pieceCode,
    Expression<String>? pieceLibelle,
    Expression<String>? serviceId,
    Expression<int>? piecesAffectees,
    Expression<int>? piecesScannees,
    Expression<int>? nbScans,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (campagneId != null) 'campagne_id': campagneId,
      if (type != null) 'type': type,
      if (lieuId != null) 'lieu_id': lieuId,
      if (lieuNom != null) 'lieu_nom': lieuNom,
      if (pieceId != null) 'piece_id': pieceId,
      if (pieceCode != null) 'piece_code': pieceCode,
      if (pieceLibelle != null) 'piece_libelle': pieceLibelle,
      if (serviceId != null) 'service_id': serviceId,
      if (piecesAffectees != null) 'pieces_affectees': piecesAffectees,
      if (piecesScannees != null) 'pieces_scannees': piecesScannees,
      if (nbScans != null) 'nb_scans': nbScans,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AffectationsCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? campagneId,
    Value<String>? type,
    Value<String?>? lieuId,
    Value<String?>? lieuNom,
    Value<String?>? pieceId,
    Value<String?>? pieceCode,
    Value<String?>? pieceLibelle,
    Value<String?>? serviceId,
    Value<int>? piecesAffectees,
    Value<int>? piecesScannees,
    Value<int>? nbScans,
    Value<int>? rowid,
  }) {
    return AffectationsCacheCompanion(
      id: id ?? this.id,
      campagneId: campagneId ?? this.campagneId,
      type: type ?? this.type,
      lieuId: lieuId ?? this.lieuId,
      lieuNom: lieuNom ?? this.lieuNom,
      pieceId: pieceId ?? this.pieceId,
      pieceCode: pieceCode ?? this.pieceCode,
      pieceLibelle: pieceLibelle ?? this.pieceLibelle,
      serviceId: serviceId ?? this.serviceId,
      piecesAffectees: piecesAffectees ?? this.piecesAffectees,
      piecesScannees: piecesScannees ?? this.piecesScannees,
      nbScans: nbScans ?? this.nbScans,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (campagneId.present) {
      map['campagne_id'] = Variable<String>(campagneId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lieuId.present) {
      map['lieu_id'] = Variable<String>(lieuId.value);
    }
    if (lieuNom.present) {
      map['lieu_nom'] = Variable<String>(lieuNom.value);
    }
    if (pieceId.present) {
      map['piece_id'] = Variable<String>(pieceId.value);
    }
    if (pieceCode.present) {
      map['piece_code'] = Variable<String>(pieceCode.value);
    }
    if (pieceLibelle.present) {
      map['piece_libelle'] = Variable<String>(pieceLibelle.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (piecesAffectees.present) {
      map['pieces_affectees'] = Variable<int>(piecesAffectees.value);
    }
    if (piecesScannees.present) {
      map['pieces_scannees'] = Variable<int>(piecesScannees.value);
    }
    if (nbScans.present) {
      map['nb_scans'] = Variable<int>(nbScans.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AffectationsCacheCompanion(')
          ..write('id: $id, ')
          ..write('campagneId: $campagneId, ')
          ..write('type: $type, ')
          ..write('lieuId: $lieuId, ')
          ..write('lieuNom: $lieuNom, ')
          ..write('pieceId: $pieceId, ')
          ..write('pieceCode: $pieceCode, ')
          ..write('pieceLibelle: $pieceLibelle, ')
          ..write('serviceId: $serviceId, ')
          ..write('piecesAffectees: $piecesAffectees, ')
          ..write('piecesScannees: $piecesScannees, ')
          ..write('nbScans: $nbScans, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LieuxCacheTable lieuxCache = $LieuxCacheTable(this);
  late final $ServicesCacheTable servicesCache = $ServicesCacheTable(this);
  late final $PiecesCacheTable piecesCache = $PiecesCacheTable(this);
  late final $BiensCacheTable biensCache = $BiensCacheTable(this);
  late final $ServicesLocauxTable servicesLocaux = $ServicesLocauxTable(this);
  late final $ScansLocauxTable scansLocaux = $ScansLocauxTable(this);
  late final $MetaTable meta = $MetaTable(this);
  late final $ScansCampagneTable scansCampagne = $ScansCampagneTable(this);
  late final $AffectationsCacheTable affectationsCache =
      $AffectationsCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    lieuxCache,
    servicesCache,
    piecesCache,
    biensCache,
    servicesLocaux,
    scansLocaux,
    meta,
    scansCampagne,
    affectationsCache,
  ];
}

typedef $$LieuxCacheTableCreateCompanionBuilder =
    LieuxCacheCompanion Function({
      required String id,
      required String code,
      required String nom,
      Value<int> rowid,
    });
typedef $$LieuxCacheTableUpdateCompanionBuilder =
    LieuxCacheCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> nom,
      Value<int> rowid,
    });

class $$LieuxCacheTableFilterComposer
    extends Composer<_$AppDatabase, $LieuxCacheTable> {
  $$LieuxCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LieuxCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $LieuxCacheTable> {
  $$LieuxCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LieuxCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $LieuxCacheTable> {
  $$LieuxCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);
}

class $$LieuxCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LieuxCacheTable,
          LieuxCacheData,
          $$LieuxCacheTableFilterComposer,
          $$LieuxCacheTableOrderingComposer,
          $$LieuxCacheTableAnnotationComposer,
          $$LieuxCacheTableCreateCompanionBuilder,
          $$LieuxCacheTableUpdateCompanionBuilder,
          (
            LieuxCacheData,
            BaseReferences<_$AppDatabase, $LieuxCacheTable, LieuxCacheData>,
          ),
          LieuxCacheData,
          PrefetchHooks Function()
        > {
  $$LieuxCacheTableTableManager(_$AppDatabase db, $LieuxCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LieuxCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LieuxCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LieuxCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LieuxCacheCompanion(
                id: id,
                code: code,
                nom: nom,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String nom,
                Value<int> rowid = const Value.absent(),
              }) => LieuxCacheCompanion.insert(
                id: id,
                code: code,
                nom: nom,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LieuxCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LieuxCacheTable,
      LieuxCacheData,
      $$LieuxCacheTableFilterComposer,
      $$LieuxCacheTableOrderingComposer,
      $$LieuxCacheTableAnnotationComposer,
      $$LieuxCacheTableCreateCompanionBuilder,
      $$LieuxCacheTableUpdateCompanionBuilder,
      (
        LieuxCacheData,
        BaseReferences<_$AppDatabase, $LieuxCacheTable, LieuxCacheData>,
      ),
      LieuxCacheData,
      PrefetchHooks Function()
    >;
typedef $$ServicesCacheTableCreateCompanionBuilder =
    ServicesCacheCompanion Function({
      required String id,
      required String nom,
      required String lieuId,
      Value<bool> actif,
      Value<int> rowid,
    });
typedef $$ServicesCacheTableUpdateCompanionBuilder =
    ServicesCacheCompanion Function({
      Value<String> id,
      Value<String> nom,
      Value<String> lieuId,
      Value<bool> actif,
      Value<int> rowid,
    });

class $$ServicesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesCacheTable> {
  $$ServicesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get actif => $composableBuilder(
    column: $table.actif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServicesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesCacheTable> {
  $$ServicesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get actif => $composableBuilder(
    column: $table.actif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServicesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesCacheTable> {
  $$ServicesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get lieuId =>
      $composableBuilder(column: $table.lieuId, builder: (column) => column);

  GeneratedColumn<bool> get actif =>
      $composableBuilder(column: $table.actif, builder: (column) => column);
}

class $$ServicesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServicesCacheTable,
          ServicesCacheData,
          $$ServicesCacheTableFilterComposer,
          $$ServicesCacheTableOrderingComposer,
          $$ServicesCacheTableAnnotationComposer,
          $$ServicesCacheTableCreateCompanionBuilder,
          $$ServicesCacheTableUpdateCompanionBuilder,
          (
            ServicesCacheData,
            BaseReferences<
              _$AppDatabase,
              $ServicesCacheTable,
              ServicesCacheData
            >,
          ),
          ServicesCacheData,
          PrefetchHooks Function()
        > {
  $$ServicesCacheTableTableManager(_$AppDatabase db, $ServicesCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String> lieuId = const Value.absent(),
                Value<bool> actif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesCacheCompanion(
                id: id,
                nom: nom,
                lieuId: lieuId,
                actif: actif,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nom,
                required String lieuId,
                Value<bool> actif = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesCacheCompanion.insert(
                id: id,
                nom: nom,
                lieuId: lieuId,
                actif: actif,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServicesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServicesCacheTable,
      ServicesCacheData,
      $$ServicesCacheTableFilterComposer,
      $$ServicesCacheTableOrderingComposer,
      $$ServicesCacheTableAnnotationComposer,
      $$ServicesCacheTableCreateCompanionBuilder,
      $$ServicesCacheTableUpdateCompanionBuilder,
      (
        ServicesCacheData,
        BaseReferences<_$AppDatabase, $ServicesCacheTable, ServicesCacheData>,
      ),
      ServicesCacheData,
      PrefetchHooks Function()
    >;
typedef $$PiecesCacheTableCreateCompanionBuilder =
    PiecesCacheCompanion Function({
      required String id,
      required String code,
      required String libelle,
      Value<String?> batiment,
      Value<String?> niveau,
      required String lieuId,
      Value<String?> serviceId,
      Value<int> rowid,
    });
typedef $$PiecesCacheTableUpdateCompanionBuilder =
    PiecesCacheCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> libelle,
      Value<String?> batiment,
      Value<String?> niveau,
      Value<String> lieuId,
      Value<String?> serviceId,
      Value<int> rowid,
    });

class $$PiecesCacheTableFilterComposer
    extends Composer<_$AppDatabase, $PiecesCacheTable> {
  $$PiecesCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batiment => $composableBuilder(
    column: $table.batiment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PiecesCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $PiecesCacheTable> {
  $$PiecesCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get libelle => $composableBuilder(
    column: $table.libelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batiment => $composableBuilder(
    column: $table.batiment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get niveau => $composableBuilder(
    column: $table.niveau,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PiecesCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $PiecesCacheTable> {
  $$PiecesCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get libelle =>
      $composableBuilder(column: $table.libelle, builder: (column) => column);

  GeneratedColumn<String> get batiment =>
      $composableBuilder(column: $table.batiment, builder: (column) => column);

  GeneratedColumn<String> get niveau =>
      $composableBuilder(column: $table.niveau, builder: (column) => column);

  GeneratedColumn<String> get lieuId =>
      $composableBuilder(column: $table.lieuId, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);
}

class $$PiecesCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PiecesCacheTable,
          PiecesCacheData,
          $$PiecesCacheTableFilterComposer,
          $$PiecesCacheTableOrderingComposer,
          $$PiecesCacheTableAnnotationComposer,
          $$PiecesCacheTableCreateCompanionBuilder,
          $$PiecesCacheTableUpdateCompanionBuilder,
          (
            PiecesCacheData,
            BaseReferences<_$AppDatabase, $PiecesCacheTable, PiecesCacheData>,
          ),
          PiecesCacheData,
          PrefetchHooks Function()
        > {
  $$PiecesCacheTableTableManager(_$AppDatabase db, $PiecesCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PiecesCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PiecesCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PiecesCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> libelle = const Value.absent(),
                Value<String?> batiment = const Value.absent(),
                Value<String?> niveau = const Value.absent(),
                Value<String> lieuId = const Value.absent(),
                Value<String?> serviceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PiecesCacheCompanion(
                id: id,
                code: code,
                libelle: libelle,
                batiment: batiment,
                niveau: niveau,
                lieuId: lieuId,
                serviceId: serviceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String libelle,
                Value<String?> batiment = const Value.absent(),
                Value<String?> niveau = const Value.absent(),
                required String lieuId,
                Value<String?> serviceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PiecesCacheCompanion.insert(
                id: id,
                code: code,
                libelle: libelle,
                batiment: batiment,
                niveau: niveau,
                lieuId: lieuId,
                serviceId: serviceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PiecesCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PiecesCacheTable,
      PiecesCacheData,
      $$PiecesCacheTableFilterComposer,
      $$PiecesCacheTableOrderingComposer,
      $$PiecesCacheTableAnnotationComposer,
      $$PiecesCacheTableCreateCompanionBuilder,
      $$PiecesCacheTableUpdateCompanionBuilder,
      (
        PiecesCacheData,
        BaseReferences<_$AppDatabase, $PiecesCacheTable, PiecesCacheData>,
      ),
      PiecesCacheData,
      PrefetchHooks Function()
    >;
typedef $$BiensCacheTableCreateCompanionBuilder =
    BiensCacheCompanion Function({
      required String numeroInventaire,
      required String id,
      required String designation,
      required String statut,
      Value<int> rowid,
    });
typedef $$BiensCacheTableUpdateCompanionBuilder =
    BiensCacheCompanion Function({
      Value<String> numeroInventaire,
      Value<String> id,
      Value<String> designation,
      Value<String> statut,
      Value<int> rowid,
    });

class $$BiensCacheTableFilterComposer
    extends Composer<_$AppDatabase, $BiensCacheTable> {
  $$BiensCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get numeroInventaire => $composableBuilder(
    column: $table.numeroInventaire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BiensCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $BiensCacheTable> {
  $$BiensCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get numeroInventaire => $composableBuilder(
    column: $table.numeroInventaire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BiensCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $BiensCacheTable> {
  $$BiensCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get numeroInventaire => $composableBuilder(
    column: $table.numeroInventaire,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);
}

class $$BiensCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BiensCacheTable,
          BiensCacheData,
          $$BiensCacheTableFilterComposer,
          $$BiensCacheTableOrderingComposer,
          $$BiensCacheTableAnnotationComposer,
          $$BiensCacheTableCreateCompanionBuilder,
          $$BiensCacheTableUpdateCompanionBuilder,
          (
            BiensCacheData,
            BaseReferences<_$AppDatabase, $BiensCacheTable, BiensCacheData>,
          ),
          BiensCacheData,
          PrefetchHooks Function()
        > {
  $$BiensCacheTableTableManager(_$AppDatabase db, $BiensCacheTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BiensCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BiensCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BiensCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> numeroInventaire = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> designation = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BiensCacheCompanion(
                numeroInventaire: numeroInventaire,
                id: id,
                designation: designation,
                statut: statut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String numeroInventaire,
                required String id,
                required String designation,
                required String statut,
                Value<int> rowid = const Value.absent(),
              }) => BiensCacheCompanion.insert(
                numeroInventaire: numeroInventaire,
                id: id,
                designation: designation,
                statut: statut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BiensCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BiensCacheTable,
      BiensCacheData,
      $$BiensCacheTableFilterComposer,
      $$BiensCacheTableOrderingComposer,
      $$BiensCacheTableAnnotationComposer,
      $$BiensCacheTableCreateCompanionBuilder,
      $$BiensCacheTableUpdateCompanionBuilder,
      (
        BiensCacheData,
        BaseReferences<_$AppDatabase, $BiensCacheTable, BiensCacheData>,
      ),
      BiensCacheData,
      PrefetchHooks Function()
    >;
typedef $$ServicesLocauxTableCreateCompanionBuilder =
    ServicesLocauxCompanion Function({
      required String localId,
      required String lieuId,
      required String nom,
      Value<String?> serverId,
      Value<int> rowid,
    });
typedef $$ServicesLocauxTableUpdateCompanionBuilder =
    ServicesLocauxCompanion Function({
      Value<String> localId,
      Value<String> lieuId,
      Value<String> nom,
      Value<String?> serverId,
      Value<int> rowid,
    });

class $$ServicesLocauxTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesLocauxTable> {
  $$ServicesLocauxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServicesLocauxTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesLocauxTable> {
  $$ServicesLocauxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServicesLocauxTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesLocauxTable> {
  $$ServicesLocauxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get lieuId =>
      $composableBuilder(column: $table.lieuId, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);
}

class $$ServicesLocauxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServicesLocauxTable,
          ServicesLocauxData,
          $$ServicesLocauxTableFilterComposer,
          $$ServicesLocauxTableOrderingComposer,
          $$ServicesLocauxTableAnnotationComposer,
          $$ServicesLocauxTableCreateCompanionBuilder,
          $$ServicesLocauxTableUpdateCompanionBuilder,
          (
            ServicesLocauxData,
            BaseReferences<
              _$AppDatabase,
              $ServicesLocauxTable,
              ServicesLocauxData
            >,
          ),
          ServicesLocauxData,
          PrefetchHooks Function()
        > {
  $$ServicesLocauxTableTableManager(
    _$AppDatabase db,
    $ServicesLocauxTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesLocauxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesLocauxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesLocauxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> localId = const Value.absent(),
                Value<String> lieuId = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesLocauxCompanion(
                localId: localId,
                lieuId: lieuId,
                nom: nom,
                serverId: serverId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String localId,
                required String lieuId,
                required String nom,
                Value<String?> serverId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesLocauxCompanion.insert(
                localId: localId,
                lieuId: lieuId,
                nom: nom,
                serverId: serverId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServicesLocauxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServicesLocauxTable,
      ServicesLocauxData,
      $$ServicesLocauxTableFilterComposer,
      $$ServicesLocauxTableOrderingComposer,
      $$ServicesLocauxTableAnnotationComposer,
      $$ServicesLocauxTableCreateCompanionBuilder,
      $$ServicesLocauxTableUpdateCompanionBuilder,
      (
        ServicesLocauxData,
        BaseReferences<_$AppDatabase, $ServicesLocauxTable, ServicesLocauxData>,
      ),
      ServicesLocauxData,
      PrefetchHooks Function()
    >;
typedef $$ScansLocauxTableCreateCompanionBuilder =
    ScansLocauxCompanion Function({
      required String id,
      required String campagneId,
      required String numeroInventaire,
      required String pieceId,
      Value<String?> serviceId,
      Value<String?> serviceLocalId,
      Value<String?> responsable,
      required String etat,
      Value<String?> commentaire,
      Value<String?> photoLocale,
      Value<String?> photoUrl,
      required DateTime scanneLe,
      Value<String> statut,
      Value<String?> motif,
      required DateTime creeLe,
      Value<bool> saisieManuelle,
      Value<int> rowid,
    });
typedef $$ScansLocauxTableUpdateCompanionBuilder =
    ScansLocauxCompanion Function({
      Value<String> id,
      Value<String> campagneId,
      Value<String> numeroInventaire,
      Value<String> pieceId,
      Value<String?> serviceId,
      Value<String?> serviceLocalId,
      Value<String?> responsable,
      Value<String> etat,
      Value<String?> commentaire,
      Value<String?> photoLocale,
      Value<String?> photoUrl,
      Value<DateTime> scanneLe,
      Value<String> statut,
      Value<String?> motif,
      Value<DateTime> creeLe,
      Value<bool> saisieManuelle,
      Value<int> rowid,
    });

class $$ScansLocauxTableFilterComposer
    extends Composer<_$AppDatabase, $ScansLocauxTable> {
  $$ScansLocauxTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroInventaire => $composableBuilder(
    column: $table.numeroInventaire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pieceId => $composableBuilder(
    column: $table.pieceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceLocalId => $composableBuilder(
    column: $table.serviceLocalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responsable => $composableBuilder(
    column: $table.responsable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etat => $composableBuilder(
    column: $table.etat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commentaire => $composableBuilder(
    column: $table.commentaire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoLocale => $composableBuilder(
    column: $table.photoLocale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scanneLe => $composableBuilder(
    column: $table.scanneLe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motif => $composableBuilder(
    column: $table.motif,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creeLe => $composableBuilder(
    column: $table.creeLe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get saisieManuelle => $composableBuilder(
    column: $table.saisieManuelle,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScansLocauxTableOrderingComposer
    extends Composer<_$AppDatabase, $ScansLocauxTable> {
  $$ScansLocauxTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroInventaire => $composableBuilder(
    column: $table.numeroInventaire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pieceId => $composableBuilder(
    column: $table.pieceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceLocalId => $composableBuilder(
    column: $table.serviceLocalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responsable => $composableBuilder(
    column: $table.responsable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etat => $composableBuilder(
    column: $table.etat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commentaire => $composableBuilder(
    column: $table.commentaire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoLocale => $composableBuilder(
    column: $table.photoLocale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scanneLe => $composableBuilder(
    column: $table.scanneLe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motif => $composableBuilder(
    column: $table.motif,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creeLe => $composableBuilder(
    column: $table.creeLe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get saisieManuelle => $composableBuilder(
    column: $table.saisieManuelle,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScansLocauxTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScansLocauxTable> {
  $$ScansLocauxTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get numeroInventaire => $composableBuilder(
    column: $table.numeroInventaire,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pieceId =>
      $composableBuilder(column: $table.pieceId, builder: (column) => column);

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<String> get serviceLocalId => $composableBuilder(
    column: $table.serviceLocalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responsable => $composableBuilder(
    column: $table.responsable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get etat =>
      $composableBuilder(column: $table.etat, builder: (column) => column);

  GeneratedColumn<String> get commentaire => $composableBuilder(
    column: $table.commentaire,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoLocale => $composableBuilder(
    column: $table.photoLocale,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get scanneLe =>
      $composableBuilder(column: $table.scanneLe, builder: (column) => column);

  GeneratedColumn<String> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<String> get motif =>
      $composableBuilder(column: $table.motif, builder: (column) => column);

  GeneratedColumn<DateTime> get creeLe =>
      $composableBuilder(column: $table.creeLe, builder: (column) => column);

  GeneratedColumn<bool> get saisieManuelle => $composableBuilder(
    column: $table.saisieManuelle,
    builder: (column) => column,
  );
}

class $$ScansLocauxTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScansLocauxTable,
          ScansLocauxData,
          $$ScansLocauxTableFilterComposer,
          $$ScansLocauxTableOrderingComposer,
          $$ScansLocauxTableAnnotationComposer,
          $$ScansLocauxTableCreateCompanionBuilder,
          $$ScansLocauxTableUpdateCompanionBuilder,
          (
            ScansLocauxData,
            BaseReferences<_$AppDatabase, $ScansLocauxTable, ScansLocauxData>,
          ),
          ScansLocauxData,
          PrefetchHooks Function()
        > {
  $$ScansLocauxTableTableManager(_$AppDatabase db, $ScansLocauxTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScansLocauxTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScansLocauxTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScansLocauxTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> campagneId = const Value.absent(),
                Value<String> numeroInventaire = const Value.absent(),
                Value<String> pieceId = const Value.absent(),
                Value<String?> serviceId = const Value.absent(),
                Value<String?> serviceLocalId = const Value.absent(),
                Value<String?> responsable = const Value.absent(),
                Value<String> etat = const Value.absent(),
                Value<String?> commentaire = const Value.absent(),
                Value<String?> photoLocale = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> scanneLe = const Value.absent(),
                Value<String> statut = const Value.absent(),
                Value<String?> motif = const Value.absent(),
                Value<DateTime> creeLe = const Value.absent(),
                Value<bool> saisieManuelle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScansLocauxCompanion(
                id: id,
                campagneId: campagneId,
                numeroInventaire: numeroInventaire,
                pieceId: pieceId,
                serviceId: serviceId,
                serviceLocalId: serviceLocalId,
                responsable: responsable,
                etat: etat,
                commentaire: commentaire,
                photoLocale: photoLocale,
                photoUrl: photoUrl,
                scanneLe: scanneLe,
                statut: statut,
                motif: motif,
                creeLe: creeLe,
                saisieManuelle: saisieManuelle,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String campagneId,
                required String numeroInventaire,
                required String pieceId,
                Value<String?> serviceId = const Value.absent(),
                Value<String?> serviceLocalId = const Value.absent(),
                Value<String?> responsable = const Value.absent(),
                required String etat,
                Value<String?> commentaire = const Value.absent(),
                Value<String?> photoLocale = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                required DateTime scanneLe,
                Value<String> statut = const Value.absent(),
                Value<String?> motif = const Value.absent(),
                required DateTime creeLe,
                Value<bool> saisieManuelle = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScansLocauxCompanion.insert(
                id: id,
                campagneId: campagneId,
                numeroInventaire: numeroInventaire,
                pieceId: pieceId,
                serviceId: serviceId,
                serviceLocalId: serviceLocalId,
                responsable: responsable,
                etat: etat,
                commentaire: commentaire,
                photoLocale: photoLocale,
                photoUrl: photoUrl,
                scanneLe: scanneLe,
                statut: statut,
                motif: motif,
                creeLe: creeLe,
                saisieManuelle: saisieManuelle,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScansLocauxTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScansLocauxTable,
      ScansLocauxData,
      $$ScansLocauxTableFilterComposer,
      $$ScansLocauxTableOrderingComposer,
      $$ScansLocauxTableAnnotationComposer,
      $$ScansLocauxTableCreateCompanionBuilder,
      $$ScansLocauxTableUpdateCompanionBuilder,
      (
        ScansLocauxData,
        BaseReferences<_$AppDatabase, $ScansLocauxTable, ScansLocauxData>,
      ),
      ScansLocauxData,
      PrefetchHooks Function()
    >;
typedef $$MetaTableCreateCompanionBuilder =
    MetaCompanion Function({
      required String cle,
      required String valeur,
      Value<int> rowid,
    });
typedef $$MetaTableUpdateCompanionBuilder =
    MetaCompanion Function({
      Value<String> cle,
      Value<String> valeur,
      Value<int> rowid,
    });

class $$MetaTableFilterComposer extends Composer<_$AppDatabase, $MetaTable> {
  $$MetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cle => $composableBuilder(
    column: $table.cle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valeur => $composableBuilder(
    column: $table.valeur,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaTableOrderingComposer extends Composer<_$AppDatabase, $MetaTable> {
  $$MetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cle => $composableBuilder(
    column: $table.cle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valeur => $composableBuilder(
    column: $table.valeur,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetaTable> {
  $$MetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cle =>
      $composableBuilder(column: $table.cle, builder: (column) => column);

  GeneratedColumn<String> get valeur =>
      $composableBuilder(column: $table.valeur, builder: (column) => column);
}

class $$MetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetaTable,
          MetaData,
          $$MetaTableFilterComposer,
          $$MetaTableOrderingComposer,
          $$MetaTableAnnotationComposer,
          $$MetaTableCreateCompanionBuilder,
          $$MetaTableUpdateCompanionBuilder,
          (MetaData, BaseReferences<_$AppDatabase, $MetaTable, MetaData>),
          MetaData,
          PrefetchHooks Function()
        > {
  $$MetaTableTableManager(_$AppDatabase db, $MetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> cle = const Value.absent(),
                Value<String> valeur = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MetaCompanion(cle: cle, valeur: valeur, rowid: rowid),
          createCompanionCallback:
              ({
                required String cle,
                required String valeur,
                Value<int> rowid = const Value.absent(),
              }) =>
                  MetaCompanion.insert(cle: cle, valeur: valeur, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetaTable,
      MetaData,
      $$MetaTableFilterComposer,
      $$MetaTableOrderingComposer,
      $$MetaTableAnnotationComposer,
      $$MetaTableCreateCompanionBuilder,
      $$MetaTableUpdateCompanionBuilder,
      (MetaData, BaseReferences<_$AppDatabase, $MetaTable, MetaData>),
      MetaData,
      PrefetchHooks Function()
    >;
typedef $$ScansCampagneTableCreateCompanionBuilder =
    ScansCampagneCompanion Function({
      required String campagneId,
      required String bienId,
      required String numero,
      required DateTime scanneLe,
      required String agentNom,
      required String pieceCode,
      Value<int> rowid,
    });
typedef $$ScansCampagneTableUpdateCompanionBuilder =
    ScansCampagneCompanion Function({
      Value<String> campagneId,
      Value<String> bienId,
      Value<String> numero,
      Value<DateTime> scanneLe,
      Value<String> agentNom,
      Value<String> pieceCode,
      Value<int> rowid,
    });

class $$ScansCampagneTableFilterComposer
    extends Composer<_$AppDatabase, $ScansCampagneTable> {
  $$ScansCampagneTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bienId => $composableBuilder(
    column: $table.bienId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scanneLe => $composableBuilder(
    column: $table.scanneLe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get agentNom => $composableBuilder(
    column: $table.agentNom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pieceCode => $composableBuilder(
    column: $table.pieceCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScansCampagneTableOrderingComposer
    extends Composer<_$AppDatabase, $ScansCampagneTable> {
  $$ScansCampagneTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bienId => $composableBuilder(
    column: $table.bienId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numero => $composableBuilder(
    column: $table.numero,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scanneLe => $composableBuilder(
    column: $table.scanneLe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get agentNom => $composableBuilder(
    column: $table.agentNom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pieceCode => $composableBuilder(
    column: $table.pieceCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScansCampagneTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScansCampagneTable> {
  $$ScansCampagneTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bienId =>
      $composableBuilder(column: $table.bienId, builder: (column) => column);

  GeneratedColumn<String> get numero =>
      $composableBuilder(column: $table.numero, builder: (column) => column);

  GeneratedColumn<DateTime> get scanneLe =>
      $composableBuilder(column: $table.scanneLe, builder: (column) => column);

  GeneratedColumn<String> get agentNom =>
      $composableBuilder(column: $table.agentNom, builder: (column) => column);

  GeneratedColumn<String> get pieceCode =>
      $composableBuilder(column: $table.pieceCode, builder: (column) => column);
}

class $$ScansCampagneTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScansCampagneTable,
          ScansCampagneData,
          $$ScansCampagneTableFilterComposer,
          $$ScansCampagneTableOrderingComposer,
          $$ScansCampagneTableAnnotationComposer,
          $$ScansCampagneTableCreateCompanionBuilder,
          $$ScansCampagneTableUpdateCompanionBuilder,
          (
            ScansCampagneData,
            BaseReferences<
              _$AppDatabase,
              $ScansCampagneTable,
              ScansCampagneData
            >,
          ),
          ScansCampagneData,
          PrefetchHooks Function()
        > {
  $$ScansCampagneTableTableManager(_$AppDatabase db, $ScansCampagneTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScansCampagneTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScansCampagneTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScansCampagneTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> campagneId = const Value.absent(),
                Value<String> bienId = const Value.absent(),
                Value<String> numero = const Value.absent(),
                Value<DateTime> scanneLe = const Value.absent(),
                Value<String> agentNom = const Value.absent(),
                Value<String> pieceCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScansCampagneCompanion(
                campagneId: campagneId,
                bienId: bienId,
                numero: numero,
                scanneLe: scanneLe,
                agentNom: agentNom,
                pieceCode: pieceCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String campagneId,
                required String bienId,
                required String numero,
                required DateTime scanneLe,
                required String agentNom,
                required String pieceCode,
                Value<int> rowid = const Value.absent(),
              }) => ScansCampagneCompanion.insert(
                campagneId: campagneId,
                bienId: bienId,
                numero: numero,
                scanneLe: scanneLe,
                agentNom: agentNom,
                pieceCode: pieceCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScansCampagneTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScansCampagneTable,
      ScansCampagneData,
      $$ScansCampagneTableFilterComposer,
      $$ScansCampagneTableOrderingComposer,
      $$ScansCampagneTableAnnotationComposer,
      $$ScansCampagneTableCreateCompanionBuilder,
      $$ScansCampagneTableUpdateCompanionBuilder,
      (
        ScansCampagneData,
        BaseReferences<_$AppDatabase, $ScansCampagneTable, ScansCampagneData>,
      ),
      ScansCampagneData,
      PrefetchHooks Function()
    >;
typedef $$AffectationsCacheTableCreateCompanionBuilder =
    AffectationsCacheCompanion Function({
      required String id,
      required String campagneId,
      required String type,
      Value<String?> lieuId,
      Value<String?> lieuNom,
      Value<String?> pieceId,
      Value<String?> pieceCode,
      Value<String?> pieceLibelle,
      Value<String?> serviceId,
      required int piecesAffectees,
      required int piecesScannees,
      required int nbScans,
      Value<int> rowid,
    });
typedef $$AffectationsCacheTableUpdateCompanionBuilder =
    AffectationsCacheCompanion Function({
      Value<String> id,
      Value<String> campagneId,
      Value<String> type,
      Value<String?> lieuId,
      Value<String?> lieuNom,
      Value<String?> pieceId,
      Value<String?> pieceCode,
      Value<String?> pieceLibelle,
      Value<String?> serviceId,
      Value<int> piecesAffectees,
      Value<int> piecesScannees,
      Value<int> nbScans,
      Value<int> rowid,
    });

class $$AffectationsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $AffectationsCacheTable> {
  $$AffectationsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lieuNom => $composableBuilder(
    column: $table.lieuNom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pieceId => $composableBuilder(
    column: $table.pieceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pieceCode => $composableBuilder(
    column: $table.pieceCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pieceLibelle => $composableBuilder(
    column: $table.pieceLibelle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get piecesAffectees => $composableBuilder(
    column: $table.piecesAffectees,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get piecesScannees => $composableBuilder(
    column: $table.piecesScannees,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nbScans => $composableBuilder(
    column: $table.nbScans,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AffectationsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $AffectationsCacheTable> {
  $$AffectationsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lieuId => $composableBuilder(
    column: $table.lieuId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lieuNom => $composableBuilder(
    column: $table.lieuNom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pieceId => $composableBuilder(
    column: $table.pieceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pieceCode => $composableBuilder(
    column: $table.pieceCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pieceLibelle => $composableBuilder(
    column: $table.pieceLibelle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceId => $composableBuilder(
    column: $table.serviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get piecesAffectees => $composableBuilder(
    column: $table.piecesAffectees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get piecesScannees => $composableBuilder(
    column: $table.piecesScannees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nbScans => $composableBuilder(
    column: $table.nbScans,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AffectationsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $AffectationsCacheTable> {
  $$AffectationsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get campagneId => $composableBuilder(
    column: $table.campagneId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get lieuId =>
      $composableBuilder(column: $table.lieuId, builder: (column) => column);

  GeneratedColumn<String> get lieuNom =>
      $composableBuilder(column: $table.lieuNom, builder: (column) => column);

  GeneratedColumn<String> get pieceId =>
      $composableBuilder(column: $table.pieceId, builder: (column) => column);

  GeneratedColumn<String> get pieceCode =>
      $composableBuilder(column: $table.pieceCode, builder: (column) => column);

  GeneratedColumn<String> get pieceLibelle => $composableBuilder(
    column: $table.pieceLibelle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get serviceId =>
      $composableBuilder(column: $table.serviceId, builder: (column) => column);

  GeneratedColumn<int> get piecesAffectees => $composableBuilder(
    column: $table.piecesAffectees,
    builder: (column) => column,
  );

  GeneratedColumn<int> get piecesScannees => $composableBuilder(
    column: $table.piecesScannees,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nbScans =>
      $composableBuilder(column: $table.nbScans, builder: (column) => column);
}

class $$AffectationsCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AffectationsCacheTable,
          AffectationsCacheData,
          $$AffectationsCacheTableFilterComposer,
          $$AffectationsCacheTableOrderingComposer,
          $$AffectationsCacheTableAnnotationComposer,
          $$AffectationsCacheTableCreateCompanionBuilder,
          $$AffectationsCacheTableUpdateCompanionBuilder,
          (
            AffectationsCacheData,
            BaseReferences<
              _$AppDatabase,
              $AffectationsCacheTable,
              AffectationsCacheData
            >,
          ),
          AffectationsCacheData,
          PrefetchHooks Function()
        > {
  $$AffectationsCacheTableTableManager(
    _$AppDatabase db,
    $AffectationsCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AffectationsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AffectationsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AffectationsCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> campagneId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> lieuId = const Value.absent(),
                Value<String?> lieuNom = const Value.absent(),
                Value<String?> pieceId = const Value.absent(),
                Value<String?> pieceCode = const Value.absent(),
                Value<String?> pieceLibelle = const Value.absent(),
                Value<String?> serviceId = const Value.absent(),
                Value<int> piecesAffectees = const Value.absent(),
                Value<int> piecesScannees = const Value.absent(),
                Value<int> nbScans = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AffectationsCacheCompanion(
                id: id,
                campagneId: campagneId,
                type: type,
                lieuId: lieuId,
                lieuNom: lieuNom,
                pieceId: pieceId,
                pieceCode: pieceCode,
                pieceLibelle: pieceLibelle,
                serviceId: serviceId,
                piecesAffectees: piecesAffectees,
                piecesScannees: piecesScannees,
                nbScans: nbScans,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String campagneId,
                required String type,
                Value<String?> lieuId = const Value.absent(),
                Value<String?> lieuNom = const Value.absent(),
                Value<String?> pieceId = const Value.absent(),
                Value<String?> pieceCode = const Value.absent(),
                Value<String?> pieceLibelle = const Value.absent(),
                Value<String?> serviceId = const Value.absent(),
                required int piecesAffectees,
                required int piecesScannees,
                required int nbScans,
                Value<int> rowid = const Value.absent(),
              }) => AffectationsCacheCompanion.insert(
                id: id,
                campagneId: campagneId,
                type: type,
                lieuId: lieuId,
                lieuNom: lieuNom,
                pieceId: pieceId,
                pieceCode: pieceCode,
                pieceLibelle: pieceLibelle,
                serviceId: serviceId,
                piecesAffectees: piecesAffectees,
                piecesScannees: piecesScannees,
                nbScans: nbScans,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AffectationsCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AffectationsCacheTable,
      AffectationsCacheData,
      $$AffectationsCacheTableFilterComposer,
      $$AffectationsCacheTableOrderingComposer,
      $$AffectationsCacheTableAnnotationComposer,
      $$AffectationsCacheTableCreateCompanionBuilder,
      $$AffectationsCacheTableUpdateCompanionBuilder,
      (
        AffectationsCacheData,
        BaseReferences<
          _$AppDatabase,
          $AffectationsCacheTable,
          AffectationsCacheData
        >,
      ),
      AffectationsCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LieuxCacheTableTableManager get lieuxCache =>
      $$LieuxCacheTableTableManager(_db, _db.lieuxCache);
  $$ServicesCacheTableTableManager get servicesCache =>
      $$ServicesCacheTableTableManager(_db, _db.servicesCache);
  $$PiecesCacheTableTableManager get piecesCache =>
      $$PiecesCacheTableTableManager(_db, _db.piecesCache);
  $$BiensCacheTableTableManager get biensCache =>
      $$BiensCacheTableTableManager(_db, _db.biensCache);
  $$ServicesLocauxTableTableManager get servicesLocaux =>
      $$ServicesLocauxTableTableManager(_db, _db.servicesLocaux);
  $$ScansLocauxTableTableManager get scansLocaux =>
      $$ScansLocauxTableTableManager(_db, _db.scansLocaux);
  $$MetaTableTableManager get meta => $$MetaTableTableManager(_db, _db.meta);
  $$ScansCampagneTableTableManager get scansCampagne =>
      $$ScansCampagneTableTableManager(_db, _db.scansCampagne);
  $$AffectationsCacheTableTableManager get affectationsCache =>
      $$AffectationsCacheTableTableManager(_db, _db.affectationsCache);
}
