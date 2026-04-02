import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ticket_repository_provider.dart';

import '../../data/models/ticket_isar.dart';
import '../../data/repositories/ticket_repository.dart';
import '../../../../core/services/supabase_service.dart';

final singleTicketProvider =
    AsyncNotifierProvider.family<SingleTicketNotifier, TicketIsar?, String>(
      SingleTicketNotifier.new,
    );

class SingleTicketNotifier extends FamilyAsyncNotifier<TicketIsar?, String> {
  late final TicketRepository _repository;
  late final SupabaseClient _client;

  RealtimeChannel? _channel;

  @override
  Future<TicketIsar?> build(String ticketId) async {
    _repository = ref.read(ticketRepositoryProvider);
    _client = SupabaseService().client;

    ref.onDispose(() {
      if (_channel != null) {
        _client.removeChannel(_channel!);
      }
    });

    final ticket = await _repository.getTicketById(ticketId);

    _subscribe(ticketId);

    return ticket;
  }

  void _subscribe(String ticketId) {
    _channel = _client.channel('ticket_$ticketId');

    _channel!
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'tickets',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: ticketId,
          ),
          callback: (payload) async {
            final data = payload.newRecord;

            final updated = TicketIsar()
              ..id = data['id']
              ..userId = data['user_id']
              ..source = data['source']
              ..destination = data['destination']
              ..qrCode = data['qr_code']
              ..pin = data['pin']
              ..routeNo = data['route_no']?.toString()
              ..vehicleNo = data['vehicle_no']?.toString()
              ..verified = data['verified'] ?? false
              ..status = data['status'] ?? 'active'
              ..createdAt = DateTime.parse(data['created_at'])
              ..verifiedAt = data['verified_at'] != null 
                  ? DateTime.parse(data['verified_at']) 
                  : null
              ..passengerCount = data['passenger_count'] ?? 1
              ..totalPrice = (data['total_price'] ?? 0.0).toDouble();

            // Rule #116: Update local DB
            await _repository.getTicketById(updated.id); // Triggers local save in repository

            state = AsyncData(updated);
          },

        )
        .subscribe();
  }
}
