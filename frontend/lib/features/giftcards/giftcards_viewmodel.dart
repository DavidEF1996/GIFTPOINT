import 'package:flutter/material.dart';
import 'giftcard_model.dart';
import 'giftcards_service.dart';

class GiftcardsViewModel extends ChangeNotifier {
  final GiftcardsService _service = GiftcardsService();

  List<Giftcard> giftcards = [];
  bool isLoading = false;
  String? error;

  Future<void> loadGiftcards(String token) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      giftcards = await _service.fetchGiftcards(token);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
