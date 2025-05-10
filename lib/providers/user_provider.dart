import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user = UserModel(
    id: "1",
    name: "Utilisateur",
    email: "utilisateur@example.com",
    balance: 0, // Solde initial à 0
  );

  UserModel get user => _user;

  void addPoints(int points) {
    _user.addPoints(points);
    notifyListeners();
  }

  void updateUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
} 