import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/ticket_repository.dart';
import '../../data/repositories/ticket_local_data_source.dart';
import '../../data/repositories/ticket_remote_data_source.dart';
import '../../../../core/services/local_db_service.dart';
import '../../../../core/services/supabase_service.dart';

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final local = TicketLocalDataSource(LocalDatabaseService());
  final remote = TicketRemoteDataSource(SupabaseService());

  return TicketRepository(local, remote);
});
