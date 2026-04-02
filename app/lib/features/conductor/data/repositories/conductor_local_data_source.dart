import 'package:isar/isar.dart';

import '../../../../core/services/local_db_service.dart';
import '../models/conductor_shift_isar.dart';

class ConductorLocalDataSource {
  final LocalDatabaseService _dbService;

  ConductorLocalDataSource(this._dbService);

  Isar get _isar => _dbService.db;

  /// 💾 Save active shift (replace existing)
  Future<void> saveActiveShift(ConductorShiftIsar shift) async {
    await _isar.writeTxn(() async {
      // Ensure only ONE active shift exists
      await _isar.conductorShiftIsars.clear();
      await _isar.conductorShiftIsars.put(shift);
    });
  }

  /// 📦 Get current active shift
  Future<ConductorShiftIsar?> getActiveShift() async {
    return await _isar.conductorShiftIsars.where().findFirst();
  }

  /// 🧹 Clear shift (logout / end shift)
  Future<void> clearShift() async {
    await _isar.writeTxn(() async {
      await _isar.conductorShiftIsars.clear();
    });
  }
}