import 'package:flutter/material.dart';
import '../models/offer.dart';

class OfferProvider with ChangeNotifier {
  List<Offer> _offers = [];
  bool _isLoading = false;
  String? _error;

  List<Offer> get offers => _offers;
  bool get isLoading => _isLoading;
  String? get error => _error;

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