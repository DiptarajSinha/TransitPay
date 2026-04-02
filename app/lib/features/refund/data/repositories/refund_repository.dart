import 'dart:typed_data';
import '../models/refund.dart';
import 'refund_remote_data_source.dart';

class RefundRepository {
  final RefundRemoteDataSource _remote;

  RefundRepository(this._remote);

  Future<Refund> submitRefund({
    required String ticketId,
    required String userId,
    required String reason,
    Uint8List? videoBytes,
    String? originalFileName,
  }) async {
    return _remote.submitRefund(
      ticketId: ticketId,
      userId: userId,
      reason: reason,
      videoBytes: videoBytes,
      originalFileName: originalFileName,
    );
  }

  Future<List<Refund>> getRefunds(String userId) async {
    return _remote.fetchRefunds(userId);
  }
}
