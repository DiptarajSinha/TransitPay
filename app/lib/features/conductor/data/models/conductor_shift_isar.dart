import 'package:isar/isar.dart';

import 'conductor_shift.dart';

part 'conductor_shift_isar.g.dart';

@collection
class ConductorShiftIsar {
  // 📱 Local Isar ID (auto-increments safely)
  Id id = Isar.autoIncrement;

  // ☁️ Remote Supabase ID (Indexed for fast lookups and to prevent duplicates)
  @Index(unique: true, replace: true)
  int? remoteId;

  late String conductorId;
  late int routeNo;
  late String vehicleNo;
  late String busImageUrl;
  late DateTime startedAt;
  late bool isActive;

  /// 🔄 Convert this Isar entity back to your clean Domain Model
  ConductorShift toDomain() {
    return ConductorShift(
      id: remoteId,
      conductorId: conductorId,
      routeNo: routeNo,
      vehicleNo: vehicleNo,
      busImageUrl: busImageUrl,
      // Isar stores dates without timezone info, so we ensure it's treated as UTC safely
      startedAt: startedAt.isUtc ? startedAt : startedAt.toUtc(),
      isActive: isActive,
    );
  }

  /// 🔄 Create this Isar entity from your Domain Model
  static ConductorShiftIsar fromDomain(ConductorShift shift) {
    return ConductorShiftIsar()
      ..remoteId = shift.id
      ..conductorId = shift.conductorId
      ..routeNo = shift.routeNo
      ..vehicleNo = shift.vehicleNo
      ..busImageUrl = shift.busImageUrl
      ..startedAt = shift.startedAt.toUtc() // Always store UTC in local DB
      ..isActive = shift.isActive;
  }
}