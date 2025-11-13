import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_bloc/bloc/settings_bloc/settings_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_state.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;
  final SettingsBloc settingsBloc;

  WeatherBloc(this.repository, this.settingsBloc) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherForCurrentLocation>(_onFetchWeatherForCurrentLocation);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final result = await repository.fetchWeather(event.cityName);
      emit(WeatherLoaded(result));

      settingsBloc.add(AddCityToHistory(event.cityName));
    } catch (e) {
      emit(WeatherError('Something went wrong: $e'));
    }
  }

  Future<void> _onFetchWeatherForCurrentLocation(
    FetchWeatherForCurrentLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Location Services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }

      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      final result = await repository.fetchWeatherByCoordinates(position);

      emit(WeatherLoaded(result));

      settingsBloc.add(AddCityToHistory(result.cityName));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
