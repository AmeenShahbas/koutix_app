class Store {
  final String? id; // added optional ID for Firestore document reference
  final String name;
  final Location location;
  final String managerEmail;
  final String address;

  Store({
    this.id,
    required this.name,
    required this.location,
    required this.managerEmail,
    required this.address,
  });

  // Convert JSON to Dart object
  factory Store.fromJson(Map<String, dynamic> json, {String? id}) {
    return Store(
      id: id,
      name: json['name'] ?? '',
      location: Location.fromJson(json['location'] ?? {}),
      managerEmail: json['managerEmail'] ?? '',
      address: json['address'] ?? '',
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location.toJson(),
      'managerEmail': managerEmail,
      'address': address,
    };
  }

  Store copyWith({
    String? id,
    String? name,
    Location? location,
    String? managerEmail,
    String? address,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      managerEmail: managerEmail ?? this.managerEmail,
      address: address ?? this.address,
    );
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
