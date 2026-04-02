class Wallet {
  final String userId;
  final double balance;

  Wallet({
    required this.userId,
    required this.balance,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      userId: json['user_id'] as String,
      balance: (json['balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'balance': balance,
    };
  }
}
