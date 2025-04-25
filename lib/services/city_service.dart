import 'dart:convert';
import 'package:http/http.dart' as http;

class CityService {
  // TODO: Remplacer par votre URL d'API
  static const String baseUrl = 'https://api.bemi.com/api';

  Future<List<Map<String, dynamic>>> getBeninCities() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cities'),
        headers: {
          'Accept': 'application/json',
          // Ajoutez ici les headers nécessaires (token, etc.)
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Erreur lors du chargement des villes');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cities/search?query=$query'),
        headers: {
          'Accept': 'application/json',
          // Ajoutez ici les headers nécessaires (token, etc.)
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Erreur lors de la recherche des villes');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }
} 