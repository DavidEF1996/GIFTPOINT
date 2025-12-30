class Giftcard {
  final int id;
  final String brand;
  final int amount;
  final String currency;
  final bool available;
  final String logoUrl;

  Giftcard({
    required this.id,
    required this.brand,
    required this.amount,
    required this.currency,
    required this.available,
    required this.logoUrl,
  });

  factory Giftcard.fromJson(Map<String, dynamic> json) {
    return Giftcard(
      id: json['id'],
      brand: json['brand'],
      amount: json['amount'],
      currency: json['currency'],
      available: json['available'],
      logoUrl: json['logoUrl'],
    );
  }
}
