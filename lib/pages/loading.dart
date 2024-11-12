import 'package:flutter/material.dart';
import 'package:flutter_f1_app/services/race_data.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late Future<List<RaceData>> futureRaceData;

  // Functie die circuits ophaald vanuit race_data.dart om ze vervolgens te geven aan home.dart
  void setupCircuitData() {
    futureRaceData = RaceData.getCircuits();
    futureRaceData.then((races) {
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {'Racedata': races});
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    setupCircuitData();
  }

  // Build om het laden van de data weer te geven
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<RaceData>>(
        future: futureRaceData,
        builder: (context, dataOphalen) {
          if (dataOphalen.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Laadindicator
          } else if (dataOphalen.hasError) {
            return Center(
                child: Text('Error: ${dataOphalen.error}')); // Foutmelding
          } else if (dataOphalen.hasData) {
            return const Center(child: Text('Data correct opgehaald'));
          } else {
            return const Center(child: Text('Geen data beschikbaar'));
          }
        },
      ),
    );
  }
}
