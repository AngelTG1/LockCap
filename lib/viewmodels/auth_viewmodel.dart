import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  String? _token;
  String? get token => _token;

  Future<bool> login(String email, String password) async {
    try {
      final result = await _api.login(email, password);
      _token = result["token"]; // Guardamos token
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Login error: $e");
      return false;
    }
  }
}
