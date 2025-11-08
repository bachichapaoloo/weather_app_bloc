import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              decoration: const InputDecoration(labelText: 'Enter City', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Add the FetchWeather event to the BLoC
                // HINT: context.read<WeatherBloc>().add(...);
              },
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 30),

            // Output Area - Reactive to State changes
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                // TODO: Check the type of 'state' and return the correct widget.
                // if (state is WeatherInitial) { return ... }
                // if (state is WeatherLoading) { return CircularProgressIndicator(); }
                // if (state is WeatherLoaded) { return Text(state.weather); }
                // if (state is WeatherError) { return Text(state.message, style: TextStyle(color: red)); }

                return const SizedBox(); // Fallback
              },
            ),
          ],
        ),
      ),
    );
  }
}
