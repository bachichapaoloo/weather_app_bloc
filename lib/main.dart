import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';
import 'package:weather_app_bloc/presentation/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => WeatherRepository(),
        child: BlocProvider(
          // Create the BLoC and inject the repository it needs
          create: (context) => WeatherBloc(context.read<WeatherRepository>()),
          child: const WeatherPage(),
        ),
      ),
    );
  }
}
