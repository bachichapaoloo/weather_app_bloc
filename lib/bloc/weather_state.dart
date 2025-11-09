import 'package:equatable/equatable.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

// TODO: Complete WeatherLoaded. It needs a field to hold the temperature string.
// HINT: Add final String weather; to the constructor and to the props list [].
class WeatherLoaded extends WeatherState {
  final String weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

// TODO: Complete WeatherError. It needs a field to hold the error message.
class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
