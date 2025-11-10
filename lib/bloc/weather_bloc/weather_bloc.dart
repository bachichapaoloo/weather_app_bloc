import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_state.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      // TODO: Implement this event handler!
      // 1. Emit WeatherLoading() immediately.
      emit(WeatherLoading());

      // 2. Use try/catch block.
      try {
        final result = await repository.fetchWeather(event.cityName);
        emit(WeatherLoaded(result));
      } catch (e) {
        emit(WeatherError('Something went wrong: $e'));
      }
    });
  }
}
