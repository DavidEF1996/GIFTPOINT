import 'package:flutter/material.dart';
import 'package:frontend/core/appconfig.dart';
import 'package:frontend/features/orders/orders_service.dart';
import 'giftcard_model.dart';

class GiftcardDetailView extends StatelessWidget {
  final Giftcard giftcard;
  final String token;
  const GiftcardDetailView({
    super.key,
    required this.giftcard,
    required this.token,
  });

  Future<void> _createOrder(BuildContext context) async {
    final service = OrdersService();

    try {
      await service.createOrder(
        token: token,
        giftcardId: giftcard.id.toString(),
        amount: giftcard.amount.toDouble(),
      );

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Orden creada')));
    } catch (e) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al crear la orden: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(giftcard.brand)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              '${AppConfig.baseUrl}${giftcard.logoUrl}',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            giftcard.brand,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            '${giftcard.amount} ${giftcard.currency}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            giftcard.available ? 'Disponible' : 'No disponible',
            style: TextStyle(
              color: giftcard.available ? Colors.green : Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: giftcard.available
                ? () async {
                    await _createOrder(context);
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('Comprar'),
          ),
        ],
      ),
    );
  }
}
