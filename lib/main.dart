import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/the_api.dart';

import 'class_weather.dart';

void main() {
  runApp(const WeatherScreen());
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  late final WeatherService _weatherService;
  @override
  void initState() {
    super.initState();
    _weatherService = WeatherService(apiKey: '0798bb28ef20460fb48131231230905');
  }

  Weather? _weather;

  void _getWeather() async {
    try {
      final weather = await _weatherService.getWeather(_cityController.text);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    hintText: 'Enter city name',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _getWeather,
                  child: const Text('Get weather'),
                ),
                if (_weather != null) ...[
                  const SizedBox(height: 16.0),
                  Text(
                    _weather!.city,
                    style: const TextStyle(
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_weather!.temperature}°C',
                    style: const TextStyle(fontSize: 48.0),
                  ),
                  Text(
                    _weather!.description,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'Lat: ${_weather!.lat}',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Text(
                    'Wind: ${_weather!.wind} kph',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  Container(height: 16.0),
                  Image.network(
                    '//cdn.weatherapi.com/weather/${_weather!.icon}',
                    height: 100.0,
                  ),
                ],
              ],
            ),
          ),
        ));
  }
}
