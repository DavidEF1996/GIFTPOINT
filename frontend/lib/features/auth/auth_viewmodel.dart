import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool isLoading = false;
  String? token;
  String? error;

  Future<void> login(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await _service.login(email, password);
      token = response.token;
    } catch (e) {
      error = 'Credenciales inválidas';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
