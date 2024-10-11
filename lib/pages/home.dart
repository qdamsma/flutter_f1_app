import 'package:flutter/material.dart';
import 'package:flutter_f1_app/services/race_data.dart';
import 'dart:async';
import 'package:intl/intl.dart';


class F1_Home extends StatefulWidget {

  @override
  State<F1_Home> createState() => _F1_HomeState();
}

class _F1_HomeState extends State<F1_Home> {
  List<RaceData> circuitData = [];
  RaceData? nextRace;
  Duration timeUntilNextRace = const Duration();
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    loadCircuits();
  }

  Future<void> loadCircuits() async {
    try {
      circuitData = await RaceData.getCircuits();
      setState(() {
        nextRace = RaceData.getNextRace(circuitData);
        if (nextRace != null) {
          startCountdown(nextRace!);
        }
      });
    } catch (e) {
      print('Fout bij het laden van circuits: $e');
    }
  }

  void startCountdown(RaceData race) {
    DateTime raceDate = DateFormat('d MMM yyyy').parse(race.raceDate);
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        timeUntilNextRace = raceDate.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/assets/images/f1_logo_app.png', height: 40),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF1E00),
        elevation: 0.0,
      ),
      
      body: Column(
        children: [
          if (nextRace != null)
            Container(
              width: double.infinity,
              color: const Color(0xFFFF1E00),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Volgende GP: ${nextRace!.land}, ${nextRace!.locatie}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
                    
                    ),
                    Text(
                      '${timeUntilNextRace.inDays}d ${timeUntilNextRace.inHours % 24}h ${timeUntilNextRace.inMinutes % 60}m ${timeUntilNextRace.inSeconds % 60}s',
                      style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: circuitData.isEmpty
                ? const Center(child: Text('Geen circuits beschikbaar'))
                : ListView.builder(
                    itemCount: circuitData.length,
                    itemBuilder: (context, index) {
                      final race = circuitData[index];
                      return ListTile(
                        leading: Image.asset(
                          race.circuitImageAsset,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(race.land,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            '${race.locatie}, ${race.weekendDates.join(' - ')}'),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/circuit_detail',
                            arguments: race,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar( 
        items: const [ 
          BottomNavigationBarItem( icon: Icon(Icons.home), label: 'Home', ), 
          BottomNavigationBarItem( icon: Icon(Icons.swap_calls), label: 'Teamswapper', ), 
        ], 
        currentIndex: 0, 
        selectedItemColor: const Color(0xFFFF1E00), 
        onTap: (index) { 
          switch (index) { 
            case 0: 
            Navigator.pushReplacementNamed(context, '/home'); 
            break;
            case 1: 
            Navigator.pushReplacementNamed(context, '/teamswapper'); 
            break; 
          } 
        }, 
      ), 

    );
  }
}