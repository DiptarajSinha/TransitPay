import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';

class TicketRemoteDataSource {
  final SupabaseService _service;

  TicketRemoteDataSource(this._service);

  SupabaseClient get _client => _service.client;

  /// 📡 Active tickets
  Future<List<Map<String, dynamic>>> fetchActiveTickets(String userId) async {
    final res = await _client
        .from('tickets')
        .select()
        .eq('user_id', userId)
        .gte(
          'created_at',
          DateTime.now()
              .toUtc()
              .subtract(const Duration(hours: 12))
              .toIso8601String(),
        );

    return List<Map<String, dynamic>>.from(res);
  }

  /// 🔍 Single ticket
  Future<Map<String, dynamic>?> fetchTicketById(String id) async {
    final res = await _client
        .from('tickets')
        .select()
        .eq('id', id)
        .maybeSingle();

    return res;
  }

  /// 🔄 Verify ticket
  Future<void> updateTicket({
    required String id,
    required bool verified,
    String? routeNo,
    String? vehicleNo,
  }) async {
    await _client
        .from('tickets')
        .update({
          'verified': verified,
          if (routeNo != null) 'route_no': routeNo,
          if (vehicleNo != null) 'vehicle_no': vehicleNo,
        })
        .eq('id', id);
  }

  /// 🆕 Create ticket
  Future<Map<String, dynamic>> createTicket({
    required String userId,
    required String source,
    required String destination,
    required String qrCode,
    required String pin,
    int? passengerCount,
    double? totalPrice,
  }) async {
    final res = await _client.from('tickets').insert({
      'user_id': userId,
      'source': source,
      'destination': destination,
      'qr_code': qrCode,
      'pin': pin,
      'passenger_count': passengerCount ?? 1,
      'total_price': totalPrice ?? 0.0,
      'verified': false,
      'status': 'active',
    }).select().single();

    return res;
  }
}
