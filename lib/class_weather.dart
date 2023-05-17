class Weather {
  final String city;
  final double temperature;
  final String description;
  final double lat;
  final double wind;
  final String icon;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.lat,
    required this.wind,
    required this.icon,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      description: json['current']['condition']['text'],
      lat: json['location']['lat'].toDouble(),
      wind: json['current']['wind_kph'].toDouble(),
      icon: json['current']['condition']['icon'],
    );
  }
}
