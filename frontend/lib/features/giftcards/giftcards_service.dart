import 'dart:convert';
import 'package:http/http.dart' as http;
import 'giftcard_model.dart';

class GiftcardsService {
  static const String baseUrl = 'http://192.168.18.95:3000';

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
