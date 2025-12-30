import 'package:flutter/material.dart';
import 'package:frontend/core/appconfig.dart';
import 'orders_service.dart';

class OrdersView extends StatelessWidget {
  final String token;

  const OrdersView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis órdenes')),
      body: FutureBuilder<List<dynamic>>(
        future: OrdersService().getMyOrders(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar órdenes'));
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return const Center(child: Text('No tienes órdenes aún'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, index) {
              final order = orders[index];
              final giftcard = order['giftcard']; // 👈 CLAVE

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 6, color: Colors.black12),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${AppConfig.baseUrl}${giftcard['logoUrl']}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            giftcard['brand'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${giftcard['amount']} ${giftcard['currency']}',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Estado: ${order['status']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
