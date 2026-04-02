import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/conductor_repository.dart';
import '../../data/repositories/conductor_local_data_source.dart';
import '../../data/repositories/conductor_remote_data_source.dart';
import '../../../../core/services/local_db_service.dart';
import '../../../../core/services/supabase_service.dart';

final conductorRepositoryProvider = Provider<ConductorRepository>((ref) {
  final db = LocalDatabaseService();
  final supabase = SupabaseService();

  final local = ConductorLocalDataSource(db);
  final remote = ConductorRemoteDataSource(supabase);

  return ConductorRepository(local, remote);
});
