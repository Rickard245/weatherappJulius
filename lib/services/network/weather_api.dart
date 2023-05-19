import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/constant.dart';
import '../entities/weather/class_weather.dart';

class WeatherService {
  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String text) async {
    final uriRequest = Uri(
        scheme: 'https',
        host: weatherHost,
        path: weatherPAth,
        queryParameters: {'key': apiKey, 'q': text, 'aqi': 'no'});
    final response = await http.get(uriRequest);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      final weather = Weather.fromJson(responseJson);
      return weather;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  final String apiKey;
}
