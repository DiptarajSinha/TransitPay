import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/ticket_isar.dart';
import '../../data/repositories/ticket_repository.dart';
import '../../../../core/services/supabase_service.dart';
import 'ticket_repository_provider.dart';
import '../../../wallet/application/providers/wallet_repository_provider.dart';
import '../../../wallet/application/providers/wallet_provider.dart';
import 'package:app/features/auth/application/providers/auth_provider.dart';

final ticketProvider = AsyncNotifierProvider<TicketNotifier, List<TicketIsar>>(
  TicketNotifier.new,
);

class TicketNotifier extends AsyncNotifier<List<TicketIsar>> {
  TicketRepository? _repository;
  SupabaseClient? _client;

  RealtimeChannel? _channel;
  String? _currentUserId;

  @override
  Future<List<TicketIsar>> build() async {
    _repository = ref.read(ticketRepositoryProvider);
    final supabase = SupabaseService();
    _client = supabase.client;

    // 🛡️ Watch auth state to ensure we wait for session sync
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (user) async {
        if (user == null) {
          throw Exception('User not authenticated');
        }

        _currentUserId = user.id;

        ref.onDispose(() {
          if (_channel != null) {
            _client?.removeChannel(_channel!);
          }
        });

        final tickets = await _repository!.getTickets(user.id);
        _subscribe(user.id);
        return tickets;
      },
      loading: () => throw const AsyncLoading<List<TicketIsar>>(),
      error: (e, st) => throw e,
    );
  }

  Future<void> refreshTickets() async {
    try {
      final user = SupabaseService().currentUser;
      if (user == null) return;

      await _repository!.syncTickets(user.id);
      final updated = await _repository!.getTickets(user.id);

      state = AsyncData(updated);
    } catch (_) {}
  }

  void _subscribe(String userId) {
    if (_channel != null) return;

    _channel = _client!.channel('tickets_$userId');

    _channel!
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'tickets',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) {
            final data = payload.newRecord;

            final updatedTicket = TicketIsar()
              ..id =
                  data['id'] // UUID string
              ..userId = data['user_id']
              ..source = data['source']
              ..destination = data['destination']
              ..qrCode = data['qr_code']
              ..pin = data['pin']
              ..routeNo = data['route_no']
              ..vehicleNo = data['vehicle_no']
              ..verified = data['verified']
              ..createdAt = DateTime.parse(data['created_at'] as String);

            final current = state.value ?? [];

            final updatedList = current.map((t) {
              if (t.id == updatedTicket.id) return updatedTicket;
              return t;
            }).toList();

            state = AsyncData(updatedList);

            _repository!.syncTickets(userId).catchError((_) {});
          },
        )
        .subscribe((status, [error]) {
          if (status == RealtimeSubscribeStatus.subscribed) {
            refreshTickets();
          }
        });
  }

  Future<void> buyTicket({
    required String source,
    required String destination,
    required double cost,
    required int quantity,
  }) async {
    final userId = _currentUserId;
    if (userId == null) throw Exception("User missing");

    // 1. Deduct total exact balance
    final walletRepo = ref.read(walletRepositoryProvider);
    await walletRepo.deductBalance(userId, cost);

    // 2. Create ONE ticket with passengerCount = quantity
    final random = Random.secure();
    final pin = (1000 + random.nextInt(9000)).toString();
    final tempQr = 'TEMP-${DateTime.now().millisecondsSinceEpoch}';

    final freshTicket = await _repository!.createTicket(
      userId: userId,
      source: source,
      destination: destination,
      qrCode: tempQr,
      pin: pin,
      passengerCount: quantity,
      totalPrice: cost,
    );
    
    if (freshTicket.id.isNotEmpty) {
       freshTicket.qrCode = freshTicket.id;
    }
    List<TicketIsar> freshList = [freshTicket];
    
    await _repository!.syncTickets(userId); // force full re-sync for integrity

    final currState = state.value ?? [];
    state = AsyncData([...freshList, ...currState]);

    // 4. Force wallet to dynamically reflect deduction
    ref.read(walletProvider.notifier).refreshProfile();
  }
}
