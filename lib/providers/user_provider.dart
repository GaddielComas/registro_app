import 'package:flutter/material.dart';
import 'package:registro_app/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void registerUser(String name, String matricula, String photoPath) {
    _user = User(name: name, matricula: matricula, photoPath: photoPath);
    notifyListeners();
  }
}
