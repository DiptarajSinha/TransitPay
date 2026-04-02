import 'package:isar/isar.dart';

part 'ticket_isar.g.dart';

@collection
class TicketIsar {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  late String id; // Supabase UUID

  late String userId;

  late String source;
  late String destination;

  late String qrCode;
  late String pin;

  String? routeNo;
  String? vehicleNo;

  late bool verified;
  late String status;

  late DateTime createdAt;
  DateTime? verifiedAt;

  // Passenger & pricing
  int passengerCount = 1;
  double totalPrice = 0.0;

}
