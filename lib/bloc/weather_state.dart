import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_event.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()) {
    // Register the handler for FetchWeather event
    on<FetchWeather>(_onFetchWeather);
  }

  // The logic handler
  void _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    // TODO: 1. Emit WeatherLoading state immediately so UI shows a spinner

    try {
      // TODO: 2. Call the repository to get data: await repository.fetchWeather(event.cityName)
      // TODO: 3. If successful, emit WeatherLoaded with the data
    } catch (e) {
      // TODO: 4. If an error occurs, emit WeatherError with a message
    }
  }
}
