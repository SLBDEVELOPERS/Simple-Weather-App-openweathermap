import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lk_app_weather/data/models/weather_data.dart';
import 'package:lk_app_weather/providers/weather_provider.dart';

class WeatherPage extends ConsumerWidget {
  final TextEditingController _textEditingController = TextEditingController();

  WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.read(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: MediaQuery.of(context).size.width * .05,
              ),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  maxLines: 1,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    //errorText: _validate ? null : null,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    icon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 0,
                      bottom: 11,
                      top: 11,
                      right: 15,
                    ),
                    hintText: "Search Location",
                  ),
                  onSubmitted: (value) async {
                    final location = _textEditingController.text;
                    if (location.isNotEmpty) {
                      WeatherData weatherData =
                          await weather.getCurrentWeather(location);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Current Weather'),
                            content: Text('Location: ${weatherData.cityName}\n'
                                'Temperature: ${weatherData.temp.toStringAsFixed(1)}°C\n'
                                'Humidity: ${weatherData.humidity.toStringAsFixed(1)}%\n'
                                'Wind Speed : ${weatherData.windSpeed.toStringAsFixed(1)}%\n'
                                'Description: ${weatherData.description}'),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
