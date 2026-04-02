import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/ticket/data/models/ticket_isar.dart';
import '../../features/conductor/data/models/conductor_shift_isar.dart';
import 'encryption_service.dart';

class LocalDatabaseService {
  static final LocalDatabaseService _instance =
      LocalDatabaseService._internal();

  factory LocalDatabaseService() => _instance;

  LocalDatabaseService._internal();

  Isar? _isar;

  Future<void> init() async {
    if (_isar != null) return;

    // Initialize encryption service to safely fetch or generate DB keys
    await EncryptionService().init();

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [TicketIsarSchema, ConductorShiftIsarSchema],
      directory: dir.path,
      name: 'transit_pay',
    );
  }

  Isar get db {
    if (_isar == null) {
      throw Exception("DB not initialized");
    }
    return _isar!;
  }
}
