// File location: features/conductor/data/models/conductor_shift.dart

class ConductorShift {
  final int? id; // 🚀 Made nullable so you can create a shift before Supabase assigns an ID
  final String conductorId;
  final int routeNo;
  final String? source;
  final String? destination;
  final String vehicleNo;
  final String busImageUrl;
  final DateTime startedAt;
  final bool isActive;

  const ConductorShift({
    this.id, // Optional for new inserts
    required this.conductorId,
    required this.routeNo,
    this.source,
    this.destination,
    required this.vehicleNo,
    required this.busImageUrl,
    required this.startedAt,
    required this.isActive,
  });

  /// 🔄 From Supabase JSON
  factory ConductorShift.fromJson(Map<String, dynamic> json) {
    // 🛡️ Robust parsing to prevent "String is not a subtype of int?" crashes
    int? parseId(dynamic value) {
       if (value == null) return null;
       if (value is int) return value;
       return int.tryParse(value.toString());
    }

    int parseRoute(dynamic value) {
       if (value is int) return value;
       return int.tryParse(value.toString()) ?? 101; // Mock fallback
    }

    return ConductorShift(
      id: parseId(json['id']),
      conductorId: json['conductor_id'] as String,
      routeNo: parseRoute(json['route_no']),
      source: json['source'] as String?,
      destination: json['destination'] as String?,
      vehicleNo: json['vehicle_no'] as String,
      busImageUrl: json['bus_image_url'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      isActive: json['is_active'] as bool,
    );
  }

  /// 🔄 To Supabase JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id, // Only send ID if it exists
      'conductor_id': conductorId,
      'route_no': routeNo,
      'source': source,
      'destination': destination,
      'vehicle_no': vehicleNo,
      'bus_image_url': busImageUrl,
      // 🚀 Added .toUtc() for safe Postgres timestamping
      'started_at': startedAt.toUtc().toIso8601String(), 
      'is_active': isActive,
    };
  }

  /// 🔄 Copy with (useful for state updates)
  ConductorShift copyWith({
    int? id,
    String? conductorId,
    int? routeNo,
    String? source,
    String? destination,
    String? vehicleNo,
    String? busImageUrl,
    DateTime? startedAt,
    bool? isActive,
  }) {
    return ConductorShift(
      id: id ?? this.id,
      conductorId: conductorId ?? this.conductorId,
      routeNo: routeNo ?? this.routeNo,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      busImageUrl: busImageUrl ?? this.busImageUrl,
      startedAt: startedAt ?? this.startedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}