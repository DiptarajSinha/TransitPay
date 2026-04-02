import 'package:isar/isar.dart';

import '../../../../core/services/encryption_service.dart';
import '../../../../core/services/local_db_service.dart';
import '../models/ticket_isar.dart';

class TicketLocalDataSource {
  final LocalDatabaseService _db;
  final EncryptionService _encService = EncryptionService();

  TicketLocalDataSource(this._db);

  Isar get _isar => _db.db;

  TicketIsar _encryptTicket(TicketIsar ticket) {
    if (ticket.qrCode.isNotEmpty) {
      ticket.qrCode = _encService.encryptField(ticket.qrCode);
    }
    return ticket;
  }

  TicketIsar _decryptTicket(TicketIsar ticket) {
    if (ticket.qrCode.isNotEmpty) {
      ticket.qrCode = _encService.decryptField(ticket.qrCode);
    }
    return ticket;
  }

  /// Save one
  Future<void> saveTicket(TicketIsar ticket) async {
    final existing = await getTicketById(ticket.id);
    if (existing != null) ticket.isarId = existing.isarId;

    final encTicket = _encryptTicket(ticket);
    await _isar.writeTxn(() async {
      await _isar.ticketIsars.put(encTicket);
    });
  }

  /// Save many
  Future<void> saveAllTickets(List<TicketIsar> tickets) async {
    await _isar.writeTxn(() async {
       for (var t in tickets) {
          final existing = await _isar.ticketIsars.filter().idEqualTo(t.id).findFirst();
          if (existing != null) t.isarId = existing.isarId;
          
          final enc = _encryptTicket(t);
          await _isar.ticketIsars.put(enc);
       }
    });
  }

  /// Get active (last 12h)
  Future<List<TicketIsar>> getActiveTickets(String userId) async {
    final cutoff = DateTime.now().subtract(const Duration(hours: 12));

    final res = await _isar.ticketIsars.filter()
      .userIdEqualTo(userId)
      .createdAtGreaterThan(cutoff)
      .findAll();
    return res.map((t) => _decryptTicket(t)).toList();
  }

  Future<List<TicketIsar>> getAllTickets(String userId) async {
    final res = await _isar.ticketIsars.filter()
      .userIdEqualTo(userId)
      .findAll();
    return res.map((t) => _decryptTicket(t)).toList();
  }

  /// Get by Supabase UUID
  Future<TicketIsar?> getTicketById(String id) async {
    final res = await _isar.ticketIsars.filter().idEqualTo(id).findFirst();
    if (res != null) {
      return _decryptTicket(res);
    }
    return null;
  }

  /// Clear expired
  Future<void> clearExpiredTickets() async {
    final cutoff = DateTime.now().subtract(const Duration(hours: 12));

    await _isar.writeTxn(() async {
      await _isar.ticketIsars.filter().createdAtLessThan(cutoff).deleteAll();
    });
  }
}
