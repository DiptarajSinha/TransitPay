class Refund {
  final String id;
  final String ticketId;
  final String userId;
  final String reason;
  final String? videoUrl;
  final String status; // pending | approved | rejected
  final DateTime createdAt;
  final String? vehicleNo;

  Refund({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.reason,
    this.videoUrl,
    required this.status,
    required this.createdAt,
    this.vehicleNo,
  });

  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      id: json['id'],
      ticketId: json['ticket_id'],
      userId: json['user_id'],
      reason: json['reason'],
      videoUrl: json['video_url'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      vehicleNo: json['vehicle_no'],
    );
  }
}
