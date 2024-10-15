import 'package:flutter/material.dart';
import 'package:flutter_f1_app/services/race_data.dart';

class CircuitDetailPage extends StatelessWidget {
  const CircuitDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    final RaceData race = ModalRoute.of(context)!.settings.arguments as RaceData;

    return Scaffold(
      appBar: AppBar(
        title: Text(race.land, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFF1E00),
        iconTheme: const IconThemeData(
          color: Colors.white, 
          ),
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
              race.circuitImageAsset,
              height: 210,
              fit: BoxFit.cover,
              ),
            ),
            Text(
              race.circuitnaam,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Locatie: ${race.locatie}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Land: ${race.land}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Details nog toevoegen',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}