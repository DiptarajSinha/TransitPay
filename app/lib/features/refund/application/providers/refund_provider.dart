import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/core/services/supabase_service.dart';
import 'package:app/features/refund/data/repositories/refund_remote_data_source.dart';
import 'package:app/features/refund/data/repositories/refund_repository.dart';
import 'package:app/features/refund/data/models/refund.dart';
import 'package:app/features/auth/application/providers/auth_provider.dart';

final refundProvider = AsyncNotifierProvider<RefundNotifier, List<Refund>>(RefundNotifier.new);

class RefundNotifier extends AsyncNotifier<List<Refund>> {
  late final RefundRepository _repository;

  @override
  Future<List<Refund>> build() async {
    final remote = RefundRemoteDataSource(SupabaseService());
    _repository = RefundRepository(remote);
    
    final user = ref.watch(authProvider).valueOrNull;
    if (user == null) return [];
    
    return _repository.getRefunds(user.id);
  }

  Future<Refund> submitRefund({
    required String ticketId,
    required String reason,
    Uint8List? videoBytes,
    String? originalFileName,
  }) async {
    final user = ref.read(authProvider).valueOrNull;
    if (user == null) throw Exception('Auth session required');

    final refund = await _repository.submitRefund(
      ticketId: ticketId,
      userId: user.id,
      reason: reason,
      videoBytes: videoBytes,
      originalFileName: originalFileName,
    );

    // Refresh list
    ref.invalidateSelf();
    return refund;
  }
}
