import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/config.dart';
import '../models/bien.dart';
import '../models/refs.dart';
import '../state/auth.dart';
import 'storage.dart';

bool _estCheminAuth(String path) => path.contains('/auth/');

/// Dio authentifié : ajoute le Bearer, rafraîchit sur 401, déconnecte si échec.
final dioProvider = Provider<Dio>((ref) {
  final store = ref.read(tokenStoreProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!_estCheminAuth(options.path)) {
          final token = await store.accessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        }
        handler.next(options);
      },
      onError: (e, handler) async {
        final estRejouable = e.response?.statusCode == 401 &&
            !_estCheminAuth(e.requestOptions.path) &&
            e.requestOptions.extra['retried'] != true;
        if (!estRejouable) {
          return handler.next(e);
        }
        final rafraichi = await ref.read(authControllerProvider.notifier).tryRefresh();
        if (!rafraichi) {
          await ref.read(authControllerProvider.notifier).logout();
          return handler.next(e);
        }
        final opts = e.requestOptions;
        opts.extra['retried'] = true;
        final token = await store.accessToken();
        if (token != null) opts.headers['Authorization'] = 'Bearer $token';
        try {
          final reponse = await dio.fetch<dynamic>(opts);
          return handler.resolve(reponse);
        } on DioException catch (err) {
          return handler.next(err);
        }
      },
    ),
  );

  return dio;
});

/// Résolution d'un scan : bien trouvé, ou inconnu du référentiel.
sealed class ResolutionBien {
  const ResolutionBien();
}

class BienTrouve extends ResolutionBien {
  final Bien bien;
  const BienTrouve(this.bien);
}

class BienInconnu extends ResolutionBien {
  final String numeroScanne;
  const BienInconnu(this.numeroScanne);
}

class ApiService {
  ApiService(this._dio);
  final Dio _dio;

  Future<Campagne?> campagneOuverte() async {
    try {
      final r = await _dio.get<Map<String, dynamic>>('/campagnes/ouverte');
      return Campagne.fromJson(r.data!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<List<Lieu>> lieux() async {
    final r = await _dio.get<List<dynamic>>('/lieux');
    return r.data!.map((e) => Lieu.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<Service>> services(String lieuId) async {
    final r = await _dio.get<List<dynamic>>('/services', queryParameters: {'lieu_id': lieuId});
    return r.data!.map((e) => Service.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// get-or-create : 201 créé / 200 existant — dans les deux cas on renvoie le service.
  Future<Service> creerService(String lieuId, String nom) async {
    final r = await _dio.post<Map<String, dynamic>>(
      '/services',
      data: {'lieu_id': lieuId, 'nom': nom},
    );
    return Service.fromJson(r.data!);
  }

  Future<List<Piece>> pieces(String lieuId, {String? q, String? serviceId}) async {
    final r = await _dio.get<List<dynamic>>(
      '/pieces',
      queryParameters: {
        'lieu_id': lieuId,
        if (q != null && q.isNotEmpty) 'q': q,
        'service_id': ?serviceId,
        'limit': 100,
      },
    );
    return r.data!.map((e) => Piece.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<ResolutionBien> bienParNumero(String numero) async {
    try {
      final r = await _dio.get<Map<String, dynamic>>(
        '/biens/par-numero/${Uri.encodeComponent(numero)}',
      );
      return BienTrouve(Bien.fromJson(r.data!));
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return BienInconnu(numero);
      rethrow;
    }
  }

  Future<Progression> progression(String campagneId) async {
    final r = await _dio.get<Map<String, dynamic>>('/campagnes/$campagneId/progression');
    return Progression.fromJson(r.data!);
  }

  /// Export du référentiel pour le cache local. `depuis` = delta incrémental.
  Future<Map<String, dynamic>> referentiel({String? depuis}) async {
    final r = await _dio.get<Map<String, dynamic>>(
      '/sync/referentiel',
      queryParameters: {'depuis': ?depuis},
    );
    return r.data!;
  }

  /// Envoi d'un lot de lignes. Renvoie le résultat par ligne.
  Future<List<ResultatSync>> syncLignes(List<Map<String, dynamic>> lignes) async {
    final r = await _dio.post<Map<String, dynamic>>(
      '/sync/lignes-inventaire',
      data: {'lignes': lignes},
    );
    return (r.data!['resultats'] as List)
        .map((e) => ResultatSync.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<String> uploadPhoto(String cheminFichier) async {
    final form = FormData.fromMap({'fichier': await MultipartFile.fromFile(cheminFichier)});
    final r = await _dio.post<Map<String, dynamic>>('/photos', data: form);
    return r.data!['url'] as String;
  }

  /// POST /lignes-inventaire. Renvoie le résultat (201 créé / 200 rejeu).
  /// Les statuts 409 (clôturée) et 422 (incohérence lieu) remontent en DioException.
  Future<LigneResultat> creerLigne({
    required String id,
    required String campagneId,
    String? bienId,
    String? numeroInventaire,
    required String pieceId,
    required String serviceId,
    String? responsable,
    required EtatConstate etat,
    String? commentaire,
    String? photoUrl,
    required DateTime scanneLe,
  }) async {
    final r = await _dio.post<Map<String, dynamic>>(
      '/lignes-inventaire',
      data: {
        'id': id,
        'campagne_id': campagneId,
        'bien_id': ?bienId,
        'numero_inventaire': ?numeroInventaire,
        'piece_id': pieceId,
        'service_id': serviceId,
        if (responsable != null && responsable.isNotEmpty) 'responsable_equipement': responsable,
        'etat_constate': etat.api,
        if (commentaire != null && commentaire.isNotEmpty) 'commentaire': commentaire,
        'photo_url': ?photoUrl,
        'scanne_le': scanneLe.toUtc().toIso8601String(),
      },
    );
    return LigneResultat(
      id: (r.data!['ligne'] as Map<String, dynamic>)['id'] as String,
      bienCree: r.data!['bien_cree'] as bool? ?? false,
      dejaEnregistre: r.statusCode == 200,
    );
  }
}

final apiProvider = Provider<ApiService>((ref) => ApiService(ref.watch(dioProvider)));
