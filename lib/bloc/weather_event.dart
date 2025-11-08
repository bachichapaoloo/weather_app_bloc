import 'package:equatable/equatable.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  late final String weather;
  // TODO: Create constructor to accept 'weather' string
  // TODO: Add 'weather' to the 'props' list so Equatable can detect changes
}

class WeatherError extends WeatherState {
  late final String message;
  // TODO: Create constructor to accept 'message' string
  // TODO: Add 'message' to the 'props' list
}
