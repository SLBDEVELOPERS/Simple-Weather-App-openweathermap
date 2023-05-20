import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/weather_data.dart';
import '../data/repositories/weather_repository.dart';

final weatherProvider = Provider<Weather>((ref) => Weather(ref));

class Weather {
  final Ref _ref;
  Weather(this._ref);

  Future<WeatherData> getCurrentWeather(String location) async {
    final repository = _ref.read(weatherRepositoryProvider);
    return repository.getCurrentWeather(location);
  }
}

final weatherRepositoryProvider =
    Provider<WeatherRepository>((ref) => WeatherRepository());
