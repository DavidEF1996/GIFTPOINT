import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'giftcards_viewmodel.dart';

class GiftcardsView extends StatelessWidget {
  final String token;

  const GiftcardsView({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GiftcardsViewModel()..loadGiftcards(token),
      child: Scaffold(
        appBar: AppBar(title: const Text('Giftcards')),
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
                final g = vm.giftcards[index];
                return ListTile(
                  leading: Image.network(
                    'http://10.0.2.2:3000${g.logoUrl}',
                    width: 40,
                  ),
                  title: Text(g.brand),
                  subtitle: Text('${g.amount} ${g.currency}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
