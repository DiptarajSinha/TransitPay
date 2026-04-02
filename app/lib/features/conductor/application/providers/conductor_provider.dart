// File location: features/conductor/application/providers/conductor_provider.dart

import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/features/conductor/data/models/conductor_shift.dart';
import 'package:app/features/conductor/data/repositories/conductor_repository.dart';
import 'package:app/features/conductor/application/providers/conductor_repository_provider.dart';

final conductorProvider =
    AsyncNotifierProvider<ConductorNotifier, ConductorShift?>(
      ConductorNotifier.new,
    );

class ConductorNotifier extends AsyncNotifier<ConductorShift?> {
  late final ConductorRepository _repository;

  @override
  Future<ConductorShift?> build() async {
    _repository = ref.read(conductorRepositoryProvider);
    return await _repository.getActiveShift();
  }

  Future<void> startShift({
    required String conductorId,
    required int routeNo,
    required String vehicleNo,
    String? source,
    String? destination,
    required String originalFileName,
    required Uint8List imageBytes,
  }) async {
    state = const AsyncLoading();

    try {
      final shift = await _repository.startShift(
        conductorId: conductorId,
        routeNo: routeNo,
        vehicleNo: vehicleNo,
        source: source,
        destination: destination,
        originalFileName: originalFileName,
        imageBytes: imageBytes,
      );

      state = AsyncData(shift);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadShift() async {
    try {
      final shift = await _repository.getActiveShift();
      state = AsyncData(shift);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// ✅ UUID verification
  Future<void> verifyTicket({required String ticketId}) async {
    try {
      await _repository.verifyTicket(ticketId: ticketId);
    } catch (e) {
      rethrow;
    }
  }

  /// ✅ PIN verification (NEW)
  Future<void> verifyTicketByPin({required String pin}) async {
    try {
      await _repository.verifyTicketByPin(pin: pin);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> endShift() async {
    try {
      await _repository.endShift();
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
