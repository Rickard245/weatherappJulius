import 'dart:convert';
import 'package:http/http.dart' as http;
import 'class_weather.dart';

class WeatherService {
  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String text) async {
    final url =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$text&aqi=no';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final responseJson = json.decode(response.body);
      print(responseJson);
      final weather = Weather(
        city: data['location']['name'],
        temperature: data['current']['temp_c'].toDouble(),
        description: data['current']['condition']['text'],
        lat: data['location']['lat'].toDouble(),
        wind: data['current']['wind_kph'].toDouble(),
       
        icon: data['current']['condition']['icon'],
      );
      return weather;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  final String apiKey;
}
