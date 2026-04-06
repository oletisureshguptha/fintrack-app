import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _user;

  String? get user => _user;

  // 🔹 Load user (auto login)
  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _user = prefs.getString('loggedInUser');
    notifyListeners();
  }

  // 🔹 Signup
  Future<void> signup(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('loggedInUser', email);

    _user = email;
    notifyListeners();
  }

  // 🔹 Login
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');

    if (email == savedEmail && password == savedPassword) {
      await prefs.setString('loggedInUser', email);

      _user = email;
      notifyListeners();
      return true;
    }

    return false;
  }

  // 🔹 Logout (keep account data)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUser');

    _user = null;
    notifyListeners();
  }
}
