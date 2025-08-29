import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  Future<void> login(String email, String password) async {
    try {
      _user = await ApiService().login(email, password);
      _token = 'sample_token'; // Replace with actual token from API response
      await StorageService().saveToken(_token!);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      _user = await ApiService().signup(name, email, password);
      _token = 'sample_token'; // Replace with actual token from API response
      await StorageService().saveToken(_token!);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    await StorageService().clearToken();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    _token = await StorageService().getToken();
    if (_token != null) {
      // Optionally fetch user data from API using token
      _user = User(id: 1, name: 'Guest', email: 'guest@example.com');
      notifyListeners();
      return true;
    }
    return false;
  }

  signupWithPhone(String s) {}
}