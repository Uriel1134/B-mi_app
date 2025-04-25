class City {
  final String name;
  final String adminName;
  final double latitude;
  final double longitude;
  final int? population;

  City({
    required this.name,
    required this.adminName,
    required this.latitude,
    required this.longitude,
    this.population,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['city'] as String,
      adminName: json['admin_name'] as String,
      latitude: json['lat'] as double,
      longitude: json['lng'] as double,
      population: json['population']?.toInt(),
    );
  }
} 