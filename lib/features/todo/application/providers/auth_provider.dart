import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;

  bool _loading = false;

  String? _error;

  User? get user => _user;

  bool get loading => _loading;

  String? get error => _error;

  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _user = _authService.currentUser;
  }

  Future<void> login(String email, String password) async {
    try {
      _loading = true;
      _error = null;

      notifyListeners();

      final user = await _authService.login(email, password);

      _user = user;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;

      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      _loading = true;
      _error = null;

      notifyListeners();

      final user = await _authService.signup(email, password);

      _user = user;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;

      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();

    _user = null;

    notifyListeners();
  }
}
