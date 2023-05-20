import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lk_app_weather/data/models/weather_data.dart';

class WeatherRepository {
  final String apiKey = '131268c865c52ec3a8eae271e1d9a182';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherData> getCurrentWeather(String location) async {
    final url = '$baseUrl?q=$location&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      log(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherData.fromJson(jsonData);
      } else {
        print(response.body);
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the weather API');
    }
  }
}
