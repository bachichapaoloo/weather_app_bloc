import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cityController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Weather BLoC")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Area
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'Enter City', prefixIcon: Icon(Icons.search), border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = cityController.text;

                // TODO: Add the FetchWeather event to the BLoC
                // HINT: context.read<WeatherBloc>().add(...);
                context.read<WeatherBloc>().add(FetchWeather(city));
              },
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 30),

            // Output Area - Reactive to State changes
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherInitial) {
                  return const Text("Enter a city to begin", style: TextStyle(fontSize: 18));
                } else if (state is WeatherLoading) {
                  // Shows while standard standard await repository.fetchWeather() is running
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  // Success! Access the data via 'state.weather'
                  return Text(
                    state.weather,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  );
                } else if (state is WeatherError) {
                  // Failure! Access the message via 'state.message'
                  return Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 18));
                }
                // Fallback for safety, though technically unreachable if all states are covered
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
