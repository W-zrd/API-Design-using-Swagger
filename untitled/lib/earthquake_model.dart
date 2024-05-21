class Earthquake {
  final double magnitude;
  final String lokasi;
  Earthquake({required this.magnitude, required this.lokasi});
  factory Earthquake.fromJson(Map<String, dynamic> json) {
    return Earthquake(
      magnitude: json['mag'].toDouble(),
      lokasi: json['place'],
    );
  }
}