import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_model.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.18.95:3000';

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
