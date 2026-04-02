// File location: features/conductor/data/repositories/conductor_repository.dart

import 'dart:typed_data';
import '../models/conductor_shift.dart';
import '../models/conductor_shift_isar.dart';
import 'conductor_local_data_source.dart';
import 'conductor_remote_data_source.dart';

class ConductorRepository {
  final ConductorLocalDataSource _local;
  final ConductorRemoteDataSource _remote;

  ConductorRepository(this._local, this._remote);

  Future<ConductorShift> startShift({
    required String conductorId,
    required int routeNo,
    required String vehicleNo,
    String? source,
    String? destination,
    required String originalFileName,
    required Uint8List imageBytes,
  }) async {
    final shift = await _remote.startShift(
      conductorId: conductorId,
      routeNo: routeNo,
      vehicleNo: vehicleNo,
      source: source,
      destination: destination,
      originalFileName: originalFileName,
      imageBytes: imageBytes,
    );

    final localShift = ConductorShiftIsar.fromDomain(shift);
    await _local.saveActiveShift(localShift);

    return shift;
  }

  Future<void> endShift() async {
    final shift = await getActiveShift();
    if (shift != null && shift.id != null) {
      await _remote.endShift(shift.id!);
    }
    await _local.clearShift();
  }

  Future<ConductorShift?> getActiveShift() async {
    final local = await _local.getActiveShift();
    return local?.toDomain();
  }

  /// ✅ QR / UUID verification
  // ✅ Check if a shift is currently active
  Future<bool> hasActiveShift() async {
    final shift = await getActiveShift();
    return shift != null;
  }
  Future<void> verifyTicket({required String ticketId}) async {
    final shift = await getActiveShift();
    if (shift == null) {
      throw StateError('No active shift found. Please start a shift before verifying tickets.');
    }
    await _remote.verifyTicket(
      ticketId: ticketId,
      routeNo: shift.routeNo,
      vehicleNo: shift.vehicleNo,
    );
  }

  /// ✅ PIN verification (NEW)
  Future<void> verifyTicketByPin({required String pin}) async {
    final shift = await getActiveShift();

    await _remote.verifyTicketByPin(
      pin: pin,
      routeNo: shift?.routeNo ?? 101, // Mock fallback
      vehicleNo: shift?.vehicleNo ?? "TEST-BUS-1",
    );
  }
}
