import 'dart:convert';
import 'package:http/http.dart' as http;
import './token_service.dart';

class AuthService {
  static const String baseUrl = 'https://bemi-back-c9784612253f.herokuapp.com/public/api'; // URL avec /public/api

  // Méthode pour l'inscription
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/auth/register');
      final body = jsonEncode({
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'name': name,
        'phone': phone,
        'city': city,
      });
      
      print('URL de la requête: $url');
      print('Headers: ${{'Content-Type': 'application/json', 'Accept': 'application/json'}}');
      print('Body: $body');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erreur lors de l\'inscription: ${response.body}');
      }
    } catch (e) {
      print('Erreur détaillée: $e');
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Méthode pour la connexion
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/auth/login');
      final body = jsonEncode({
        'email': email,
        'password': password,
      });
      
      print('URL de la requête: $url');
      print('Headers: ${{'Content-Type': 'application/json', 'Accept': 'application/json'}}');
      print('Body: $body');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      print('Status code: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data decoded: $responseData');
        return responseData;
      } else {
        print('Erreur HTTP ${response.statusCode}');
        print('Corps de la réponse d\'erreur: ${response.body}');
        throw Exception('Erreur lors de la connexion (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      print('Exception détaillée: $e');
      if (e is FormatException) {
        print('Erreur de format JSON: ${e.message}');
      }
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Méthode pour la déconnexion
  Future<void> logout(String token) async {
    try {
      await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      throw Exception('Erreur lors de la déconnexion: $e');
    }
  }

  // Méthode pour vérifier le token
  Future<bool> verifyToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Méthode statique pour récupérer les données de l'utilisateur
  static Future<Map<String, dynamic>> getUserData() async {
    try {
      final token = await TokenService.getToken();
      print('Token récupéré: $token');
      if (token == null) throw Exception('Token non trouvé');

      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data decoded: $responseData');
        
        // La réponse est directement l'objet utilisateur
        if (responseData['name'] != null) {
          return responseData;
        } else {
          print('Structure de réponse inattendue: $responseData');
          return {'name': 'Utilisateur'};
        }
      } else {
        print('Erreur HTTP ${response.statusCode}: ${response.body}');
        throw Exception('Erreur lors de la récupération des données utilisateur');
      }
    } catch (e) {
      print('Exception lors de la récupération des données utilisateur: $e');
      return {'name': 'Utilisateur'};
    }
  }
} 