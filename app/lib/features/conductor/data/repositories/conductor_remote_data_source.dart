// File location: features/conductor/data/repositories/conductor_remote_data_source.dart

import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/supabase_service.dart';
import '../models/conductor_shift.dart';

class ConductorRemoteDataSource {
  final SupabaseService _supabaseService;

  ConductorRemoteDataSource(this._supabaseService);

  SupabaseClient get _client => _supabaseService.client;

  static const String _shiftTable = 'conductor_shifts';
  static const String _ticketTable = 'tickets';
  static const String _bucket = 'bus-images';

  /// 🚀 Start shift
  Future<ConductorShift> startShift({
    required String conductorId,
    required int routeNo,
    required String vehicleNo,
    String? source,
    String? destination,
    required String originalFileName,
    required Uint8List imageBytes,
  }) async {
    final cleanFileName = originalFileName
        .split('/')
        .last
        .replaceAll(RegExp(r'[^a-zA-Z0-9.\-]'), '_');

    final uniquePath =
        '${DateTime.now().millisecondsSinceEpoch}_$cleanFileName';

    await _client.storage
        .from(_bucket)
        .uploadBinary(
          uniquePath,
          imageBytes,
          fileOptions: const FileOptions(upsert: true),
        );

    final imageUrl = _client.storage.from(_bucket).getPublicUrl(uniquePath);

    try {
      final response = await _client
          .from(_shiftTable)
          .insert({
            'conductor_id': conductorId,
            'route_no': routeNo,
            'vehicle_no': vehicleNo,
            'source': source,
            'destination': destination,
            'bus_image_url': imageUrl,
            'started_at': DateTime.now().toUtc().toIso8601String(),
            'is_active': true,
          })
          .select()
          .single();

      return ConductorShift.fromJson(response);
    } catch (e) {
      // Clean up if metadata insertion fails
      try {
        await _client.storage.from(_bucket).remove([uniquePath]);
      } catch (_) {}

      if (e.toString().contains('Bucket not found')) {
        throw Exception('ERROR: Supabase Storage Bucket "$_bucket" not found. Please create a PUBLIC bucket named "$_bucket" in your Supabase dashboard to proceed.');
      }
      throw Exception('Failed to start shift. Error: $e');
    }
  }

  /// 🏁 End shift
  Future<void> endShift(int shiftId) async {
    await _client
        .from(_shiftTable)
        .update({'is_active': false})
        .eq('id', shiftId);
  }

  /// ✅ Verify via UUID (QR flow)
  Future<void> verifyTicket({
    required String ticketId,
    required int routeNo,
    required String vehicleNo,
  }) async {
    final cutoff = DateTime.now().toUtc().subtract(const Duration(hours: 12));

    final response = await _client
        .from(_ticketTable)
        .update({
          'verified': true,
          'status': 'verified',
          'route_no': routeNo,
          'vehicle_no': vehicleNo,
          'verified_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', ticketId)
        .eq('verified', false)
        .gt('created_at', cutoff.toIso8601String())
        .select();
    
    if (response.isEmpty) {
       // 🕵️ Find out WHY it failed
       final check = await _client.from(_ticketTable).select('verified, created_at').eq('id', ticketId).maybeSingle();
       if (check == null) throw Exception('Ticket not found.');
       
       if (check['verified'] == true) throw Exception('Ticket already verified.');
       
       final createdAt = DateTime.parse(check['created_at']);
       if (DateTime.now().toUtc().isAfter(createdAt.add(const Duration(hours: 12)))) {
         throw Exception('Ticket already expired.');
       }

       throw Exception('Verification failed. Invalid ticket state.');
    }
  }

  /// ✅ Verify via PIN (MANUAL FLOW)
  Future<void> verifyTicketByPin({
    required String pin,
    required int routeNo,
    required String vehicleNo,
  }) async {
    final cutoff = DateTime.now().toUtc().subtract(const Duration(hours: 12));

    final response = await _client
        .from(_ticketTable)
        .update({
          'verified': true,
          'status': 'verified',
          'route_no': routeNo,
          'vehicle_no': vehicleNo,
          'verified_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('pin', pin)
        .eq('verified', false)
        .gt('created_at', cutoff.toIso8601String())
        .select();

    if (response.isEmpty) {
      // 🕵️ Find out WHY it failed
      final check = await _client.from(_ticketTable).select('verified, created_at').eq('pin', pin).maybeSingle();
      if (check == null) throw Exception('Invalid PIN.');
      
      if (check['verified'] == true) throw Exception('PIN already used/verified.');

      final createdAt = DateTime.parse(check['created_at']);
       if (DateTime.now().toUtc().isAfter(createdAt.add(const Duration(hours: 12)))) {
         throw Exception('Ticket already expired.');
       }

      throw Exception('Verification failed. Invalid PIN state.');
    }
  }
}
