import 'package:flutter/material.dart';
import 'package:flutter_f1_app/services/race_data.dart';

class CircuitDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final RaceData race = ModalRoute.of(context)!.settings.arguments as RaceData;

    return Scaffold(
      appBar: AppBar(
        title: Text(race.land, style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFF1E00),
        iconTheme: IconThemeData(
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Locatie: ${race.locatie}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Land: ${race.land}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Details nog toevoegen',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}