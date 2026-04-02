import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/core/services/supabase_service.dart';
import 'package:app/features/wallet/data/models/wallet.dart';
import 'package:app/features/wallet/application/providers/wallet_repository_provider.dart';
import 'package:app/features/auth/application/providers/auth_provider.dart';

final walletProvider = AsyncNotifierProvider<WalletNotifier, Wallet>(WalletNotifier.new);

class WalletNotifier extends AsyncNotifier<Wallet> {
  String? _userId;

  @override
  Future<Wallet> build() async {
    // 🛡️ Watch auth state to ensure we wait for session sync
    final authState = ref.watch(authProvider);
    
    return authState.when(
      data: (user) async {
        if (user == null) {
          // This state is reached during logout or initial load
          throw Exception("User not authenticated");
        }
        
        _userId = user.id;
        final repo = ref.read(walletRepositoryProvider);
        return await repo.getWallet(_userId!);
      },
      loading: () => throw const AsyncLoading<Wallet>(),
      error: (e, st) => throw e,
    );
  }

  Future<void> topUp(double amount) async {
    final previousState = state;
    state = const AsyncLoading();
    try {
      final repo = ref.read(walletRepositoryProvider);
      final upgraded = await repo.simulateTopUp(_userId!, amount);
      state = AsyncData(upgraded);
    } catch (e, st) {
      state = previousState;
      rethrow;
    }
  }
  
  Future<void> refreshProfile() async {
    final repo = ref.read(walletRepositoryProvider);
    state = AsyncData(await repo.getWallet(_userId!));
  }
}
