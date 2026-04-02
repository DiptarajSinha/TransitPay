import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/services/supabase_service.dart';
import 'package:app/features/refund/data/models/refund.dart';

class RefundRemoteDataSource {
  final SupabaseService _supabaseService;

  RefundRemoteDataSource(this._supabaseService);

  SupabaseClient get _client => _supabaseService.client;

  static const String _refundTable = 'refunds';
  static const String _ticketTable = 'tickets';
  static const String _bucket = 'refund-proofs';

  /// 📤 Submit Refund Request
  Future<Refund> submitRefund({
    required String ticketId,
    required String userId,
    required String reason,
    Uint8List? videoBytes,
    String? originalFileName,
  }) async {
    String? videoUrl;

    if (videoBytes != null && originalFileName != null) {
      final fileName = originalFileName.split('/').last.replaceAll(RegExp(r'[^a-zA-Z0-9.\-]'), '_');
      final uniquePath = '${userId}_${DateTime.now().millisecondsSinceEpoch}_$fileName';

      await _client.storage.from(_bucket).uploadBinary(uniquePath, videoBytes);
      videoUrl = _client.storage.from(_bucket).getPublicUrl(uniquePath);
    }

    // Capture vehicle_no from ticket if verified
    final ticketData = await _client.from(_ticketTable).select('vehicle_no').eq('id', ticketId).single();
    final vehicleNo = ticketData['vehicle_no'];

    final response = await _client.from(_refundTable).insert({
      'ticket_id': ticketId,
      'user_id': userId,
      'reason': reason,
      'video_url': videoUrl,
      'status': 'pending',
      'vehicle_no': vehicleNo,
    }).select().single();

    // Mark ticket as refunded in status (Rule #55)
    await _client.from(_ticketTable).update({'status': 'refunded'}).eq('id', ticketId);

    return Refund.fromJson(response);
  }

  /// 🔍 Fetch refunds for user
  Future<List<Refund>> fetchRefunds(String userId) async {
    final response = await _client.from(_refundTable).select().eq('user_id', userId).order('created_at', ascending: false);
    return (response as List).map((r) => Refund.fromJson(r)).toList();
  }
}
