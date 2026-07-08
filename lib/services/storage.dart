import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

/// Petit dépôt des jetons JWT dans le stockage sécurisé.
class TokenStore {
  TokenStore(this._storage);

  final FlutterSecureStorage _storage;
  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  Future<String?> accessToken() => _storage.read(key: _kAccess);
  Future<String?> refreshToken() => _storage.read(key: _kRefresh);

  Future<void> save(String access, String refresh) async {
    await _storage.write(key: _kAccess, value: access);
    await _storage.write(key: _kRefresh, value: refresh);
  }

  Future<void> clear() async {
    await _storage.delete(key: _kAccess);
    await _storage.delete(key: _kRefresh);
  }
}

final tokenStoreProvider = Provider<TokenStore>((ref) {
  return TokenStore(ref.watch(secureStorageProvider));
});
