import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/config.dart';
import '../services/storage.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  const AuthState(this.status);

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isKnown => status != AuthStatus.unknown;
}

/// Dio « nu » (sans intercepteur) pour les appels d'authentification,
/// afin d'éviter toute récursion sur le rafraîchissement.
final authDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 60), // réveil Render (offre Free)
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
});

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._ref) : super(const AuthState(AuthStatus.unknown)) {
    _bootstrap();
  }

  final Ref _ref;
  Future<bool>? _refreshEnCours;

  TokenStore get _store => _ref.read(tokenStoreProvider);
  Dio get _dio => _ref.read(authDioProvider);

  Future<void> _bootstrap() async {
    final token = await _store.accessToken();
    state = AuthState(
      token == null ? AuthStatus.unauthenticated : AuthStatus.authenticated,
    );
  }

  /// Connexion. Lève une exception avec un message lisible en cas d'échec.
  Future<void> login(String email, String motDePasse) async {
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': email.trim(), 'mot_de_passe': motDePasse},
      );
      await _store.save(r.data!['access_token'] as String, r.data!['refresh_token'] as String);
      state = const AuthState(AuthStatus.authenticated);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw 'Identifiants invalides.';
      }
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Serveur injoignable. Réessayez (le serveur peut mettre ~50 s à se réveiller).';
      }
      throw 'Échec de connexion (${e.response?.statusCode ?? e.type.name}).';
    }
  }

  /// Rafraîchit l'access token. Dédupliqué si plusieurs appels concurrents.
  Future<bool> tryRefresh() {
    return _refreshEnCours ??= _doRefresh().whenComplete(() => _refreshEnCours = null);
  }

  Future<bool> _doRefresh() async {
    final rt = await _store.refreshToken();
    if (rt == null) return false;
    try {
      final r = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': rt},
      );
      await _store.save(r.data!['access_token'] as String, r.data!['refresh_token'] as String);
      return true;
    } on DioException {
      return false;
    }
  }

  Future<void> logout() async {
    await _store.clear();
    state = const AuthState(AuthStatus.unauthenticated);
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});
