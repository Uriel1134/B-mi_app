import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  // Sauvegarder le token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Récupérer le token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Supprimer le token
  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // Vérifier si un token existe
  static Future<bool> hasToken() async {
    return await _storage.read(key: _tokenKey) != null;
  }
} 