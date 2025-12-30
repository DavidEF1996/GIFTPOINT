import 'package:flutter/material.dart';
import 'package:frontend/core/appconfig.dart';
import 'package:provider/provider.dart';
import 'giftcard_detail_view.dart';
import 'giftcards_viewmodel.dart';
import '../orders/orders_view.dart';

class GiftcardsView extends StatelessWidget {
  final String token;

  const GiftcardsView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GiftcardsViewModel()..loadGiftcards(token),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Giftcards'),
          actions: [
            IconButton(
              icon: const Icon(Icons.receipt_long),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OrdersView(token: token)),
                );
              },
            ),
          ],
        ),

        body: Consumer<GiftcardsViewModel>(
          builder: (_, vm, __) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }

            return ListView.builder(
              itemCount: vm.giftcards.length,
              itemBuilder: (_, index) {
                final giftcard = vm.giftcards[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GiftcardDetailView(
                          giftcard: giftcard,
                          token: token,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          '${AppConfig.baseUrl}${giftcard.logoUrl}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            giftcard.brand,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${giftcard.amount} ${giftcard.currency}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
