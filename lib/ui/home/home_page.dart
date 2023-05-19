import 'package:flutter/material.dart';
import 'package:weather_app/%20constant.dart';
import 'package:weather_app/services/constant.dart';
import 'package:weather_app/services/entities/weather/class_weather.dart';
import 'package:weather_app/services/network/weather_api.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  late WeatherService _weatherService;
  Weather? _weatherResponse;

  @override
  void initState() {
    _weatherService = WeatherService(apiKey: weatherKey);

    super.initState();
  }

  Future<Weather> _getWeather() async {
    try {
      String city =
          _cityController.text.isEmpty ? 'madrid' : _cityController.text;
      final weather = await _weatherService.getWeather(city);

      return weather;
    } catch (e) {
      throw Exception('Error while getting weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Weather App',
              style: const TextStyle().copyWith(color: Colors.black),
            ),
          ),
          body: FutureBuilder(
              future: _weatherService.getWeather('madrid'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
                if (snapshot.data != null) {
                  Weather weather = _weatherResponse ?? snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // ElevatedButton(
                        //   onPressed: () {
                        //     _getWeather();
                        //     print('Icon PNG path: ${_weather!.icon.substring(2)}');
                        //   },
                        //   child: const Text('Get weather'),
                        // ),
                        ...[
                          const SizedBox(height: 16.0),
                          Text(
                            weather.city,
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${weather.temperature}°C',
                            style: const TextStyle(fontSize: 48.0),
                          ),
                          Text(
                            weather.description,
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          Text(
                            'Lat: ${weather.lat}',
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          Text(
                            'Wind: ${weather.wind} kph',
                            style: const TextStyle(fontSize: 24.0),
                          ),
                          Container(height: 16.0),
                          if (weather.description.toLowerCase() ==
                              'partly cloudy')
                            Image.asset(
                              partilyCloudy,
                              height: 72,
                            ),
                        ],
                        TextField(
                          controller: _cityController,
                          decoration: const InputDecoration(
                            hintText: 'Enter city name',
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        InkWell(
                          onTap: () async {
                            final result = await _getWeather();
                            setState(() {
                              _weatherResponse = result;
                            });
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.white, border: Border.all()),
                            child: const Center(child: Text('Get Weather')),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                throw Exception('Error while Getting weather');
              }),
        ));
  }
}
