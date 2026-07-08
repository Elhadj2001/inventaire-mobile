import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/config.dart';
import '../models/bien.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: apiBaseUrl,
    connectTimeout: const Duration(seconds: 8),
    receiveTimeout: const Duration(seconds: 8),
  ));
});

/// Résultat de résolution d'un scan : bien trouvé, ou inconnu du référentiel.
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

final bienParNumeroProvider =
    FutureProvider.autoDispose.family<ResolutionBien, String>((ref, numero) async {
  final dio = ref.watch(dioProvider);
  try {
    final response =
        await dio.get<Map<String, dynamic>>('/biens/par-numero/${Uri.encodeComponent(numero)}');
    return BienTrouve(Bien.fromJson(response.data!));
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) {
      return BienInconnu(numero);
    }
    rethrow;
  }
});
