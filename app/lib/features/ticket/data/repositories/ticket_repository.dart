import '../models/ticket_isar.dart';
import 'ticket_local_data_source.dart';
import 'ticket_remote_data_source.dart';

class TicketRepository {
  final TicketLocalDataSource _local;
  final TicketRemoteDataSource _remote;

  TicketRepository(this._local, this._remote);

  /// 🔄 Map Supabase → Isar model
  TicketIsar _map(Map<String, dynamic> map) {
    return TicketIsar()
      ..id = map['id']
      ..userId = map['user_id']
      ..source = map['source']
      ..destination = map['destination']
      ..qrCode = map['qr_code']
      ..pin = map['pin']
      ..routeNo = map['route_no']
      ..vehicleNo = map['vehicle_no']
      ..verified = map['verified']
      ..status = map['status'] ?? 'active'
      ..createdAt = DateTime.parse(map['created_at'])
      ..verifiedAt = map['verified_at'] != null
          ? DateTime.parse(map['verified_at'])
          : null
      ..passengerCount = map['passenger_count'] ?? 1
      ..totalPrice = (map['total_price'] ?? 0.0).toDouble();
  }

  /// 🔄 Sync remote → local
  Future<void> syncTickets(String userId) async {
    final data = await _remote.fetchActiveTickets(userId);
    final tickets = data.map(_map).toList();
    
    for (var ticket in tickets) {
       final existing = await _local.getTicketById(ticket.id);
       if (existing != null) ticket.isarId = existing.isarId;
    }

    await _local.saveAllTickets(tickets);
  }

  /// 📦 Offline-first
  Future<List<TicketIsar>> getTickets(String userId) async {
    syncTickets(userId).catchError((_) {});
    return _local.getAllTickets(userId);
  }

  /// 🔍 Get single ticket
  Future<TicketIsar?> getTicketById(String id) async {
    // 1. Load local (fast)
    final local = await _local.getTicketById(id);

    // 2. Fetch remote (source of truth)
    try {
      final map = await _remote.fetchTicketById(id);

      if (map != null) {
        final fresh = _map(map);
        if (local != null) fresh.isarId = local.isarId;

        // update local cache
        await _local.saveTicket(fresh);

        return fresh; // ✅ always latest
      }
    } catch (_) {
      // ignore network errors
    }

    // 3. fallback to local
    return local;
  }

  /// 🆕 Create remote ticket and save to local
  Future<TicketIsar> createTicket({
    required String userId,
    required String source,
    required String destination,
    required String qrCode,
    required String pin,
    int? passengerCount,
    double? totalPrice,
  }) async {
    final map = await _remote.createTicket(
      userId: userId,
      source: source,
      destination: destination,
      qrCode: qrCode,
      pin: pin,
      passengerCount: passengerCount,
      totalPrice: totalPrice,
    );
    final fresh = _map(map);
    
    // As per the plan: these are local-only now.
    if (passengerCount != null) fresh.passengerCount = passengerCount;
    if (totalPrice != null) fresh.totalPrice = totalPrice;
    
    // Fix: Prevent "Unique index violated" by acquiring existing isarId if somehow present
    final existing = await _local.getTicketById(fresh.id);
    if (existing != null) {
      fresh.isarId = existing.isarId;
    }
    
    await _local.saveTicket(fresh);
    return fresh;
  }
}
