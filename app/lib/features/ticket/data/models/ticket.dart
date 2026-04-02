class Ticket {
  final String id;
  final String userId;
  final String source;
  final String destination;
  final String qrCode;
  final String pin;
  final String? routeNo;
  final String? vehicleNo;
  final bool verified;
  final String status;
  final DateTime createdAt;
  final DateTime? verifiedAt;

  Ticket({
    required this.id,
    required this.userId,
    required this.source,
    required this.destination,
    required this.qrCode,
    required this.pin,
    this.routeNo,
    this.vehicleNo,
    required this.verified,
    required this.status,
    required this.createdAt,
    this.verifiedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      source: json['source'] as String,
      destination: json['destination'] as String,
      qrCode: json['qr_code'] as String? ?? '', // fallback if encrypted/hidden
      pin: json['pin']?.toString() ?? '',
      routeNo: json['route_no']?.toString(),
      vehicleNo: json['vehicle_no']?.toString(),
      verified: json['verified'] as bool? ?? false,
      status: json['status'] as String? ?? 'active',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String) 
          : DateTime.now(),
      verifiedAt: json['verified_at'] != null 
          ? DateTime.parse(json['verified_at'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'source': source,
      'destination': destination,
      'qr_code': qrCode,
      'pin': pin,
      'route_no': routeNo,
      'vehicle_no': vehicleNo,
      'verified': verified,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'verified_at': verifiedAt?.toIso8601String(),
    };
  }
}