import 'dart:convert';
import 'package:frontend/core/appconfig.dart';
import 'package:http/http.dart' as http;
import 'auth_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  static String get baseUrl => dotenv.env['BASE_URL']!;

  Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw Exception('Fallo el login');
    }

    return AuthResponse.fromJson(jsonDecode(response.body));
  }
}
