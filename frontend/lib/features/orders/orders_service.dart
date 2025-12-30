import 'dart:convert';
import 'package:frontend/core/appconfig.dart';
import 'package:http/http.dart' as http;

class OrdersService {
  Future<void> createOrder({
    required String token,
    required String giftcardId,
    required double amount,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/orders'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'giftcardId': giftcardId, 'amount': amount}),
    );

    if (response.statusCode != 201) {
      throw Exception('No se pudo crear la orden');
    }
  }

  Future<List<dynamic>> getMyOrders(String token) async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/orders'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al obtener órdenes');
    }

    return jsonDecode(response.body);
  }
}
