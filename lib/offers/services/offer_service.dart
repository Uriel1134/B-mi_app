import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/offer.dart';

class OfferService {
  // TODO: Remplacer par l'URL réelle de votre API
  static const String baseUrl = 'https://api.bemi.com/api';  

  Future<List<Offer>> getOffers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/offers'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Offer.fromJson(json)).toList();
      } else {
        throw Exception('Échec du chargement des offres: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des offres: $e');
    }
  }

  Future<Offer> getOfferById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/offers/$id'));
      
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Offer.fromJson(jsonData);
      } else {
        throw Exception('Échec du chargement de l\'offre: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération de l\'offre: $e');
    }
  }
} 