import 'package:flutter/material.dart';
import '../models/offer.dart';

class OfferProvider with ChangeNotifier {
  List<Offer> _offers = [];
  bool _isLoading = false;
  String? _error;
  String _selectedCategory = 'Toutes'; // Par défaut, toutes les catégories

  List<Offer> get offers => _offers;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedCategory => _selectedCategory;

  // Récupère toutes les catégories disponibles
  List<String> get availableCategories {
    Set<String> categories = {'Toutes'};
    for (var offer in _offers) {
      categories.add(offer.category);
    }
    return categories.toList()..sort();
  }

  // Filtre les offres par catégorie
  List<Offer> get filteredOffers {
    if (_selectedCategory == 'Toutes') {
      return _offers;
    }
    return _offers
        .where((offer) => offer.category == _selectedCategory)
        .toList();
  }

  // Change la catégorie sélectionnée
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> loadOffers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    // Simulation d'un délai de chargement
    await Future.delayed(const Duration(milliseconds: 800));

    // Utilisation directe des données factices
    _offers = dummyOffers;
    _isLoading = false;
    notifyListeners();
  }

  Future<Offer?> getOfferById(String id) async {
    return _offers.firstWhere((offer) => offer.id == id);
  }
}
