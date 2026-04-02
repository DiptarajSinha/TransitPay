import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/supabase_service.dart';
import '../models/wallet.dart';

class WalletRepository {
  final SupabaseService _service;

  WalletRepository(this._service);

  SupabaseClient get _client => _service.client;

  Future<Wallet> getWallet(String userId) async {
    final res = await _client
        .from('wallets')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (res == null) {
      // Auto-initialize wallet if it lacks one
      final newRes = await _client.from('wallets').insert({
        'user_id': userId,
        'balance': 0.0,
      }).select().single();
      return Wallet.fromJson(newRes);
    }
    return Wallet.fromJson(res);
  }

  /// Initiates a mock topup (simulating a successful Stripe payment)
  Future<Wallet> simulateTopUp(String userId, double amount) async {
    final current = await getWallet(userId);
    final newBalance = current.balance + amount;

    final updated = await _client
        .from('wallets')
        .update({'balance': newBalance})
        .eq('user_id', userId)
        .select()
        .single();
    
    return Wallet.fromJson(updated);
  }

  Future<void> deductBalance(String userId, double amount) async {
    final current = await getWallet(userId);
    if (current.balance < amount) throw Exception("Insufficient balance.");

    final newBalance = current.balance - amount;

    await _client
        .from('wallets')
        .update({'balance': newBalance})
        .eq('user_id', userId);
  }
}
