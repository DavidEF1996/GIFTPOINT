import 'dart:convert';
import 'package:http/http.dart' as http;
import 'giftcard_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GiftcardsService {
  static String get baseUrl => dotenv.env['BASE_URL']!;

  Future<List<Giftcard>> fetchGiftcards(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/giftcards'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Giftcard.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar giftcards');
    }
  }
}
