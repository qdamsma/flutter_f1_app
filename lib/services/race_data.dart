import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class RaceData {
  String circuitnaam;
  String locatie;
  String land;
  String raceDate;
  List<String> weekendDates;
  String circuitImageAsset;

  RaceData({
    required this.circuitnaam,
    required this.locatie,
    required this.land,
    required this.raceDate,
    required this.weekendDates,
    required this.circuitImageAsset,
  });

  static RaceData? getNextRace(List<RaceData> races) {
    DateTime now = DateTime.now();
    for (var race in races) {
      DateTime raceDate = DateFormat('d MMM yyyy').parse(race.raceDate);
      if (raceDate.isAfter(now)) {
        return race;
      }
    }
    return null;
  }

  // Functie met switch case om de afbeeldingen te laten zien naast de circuit data
  static String getCircuitImageAsset(String circuitId) {
    switch (circuitId) {
      case 'bahrain':
        return 'lib/assets/images/circuits/Bahrein.png';
      case 'jeddah':
        return 'lib/assets/images/circuits/Jeddah.png';
      case 'albert_park':
        return 'lib/assets/images/circuits/Melbourne.png';
      case 'suzuka':
        return 'lib/assets/images/circuits/Suzuka.png';
      case 'shanghai':
        return 'lib/assets/images/circuits/Shanghai.png';
      case 'miami':
        return 'lib/assets/images/circuits/Miami.png';
      case 'imola':
        return 'lib/assets/images/circuits/Imola.png';
      case 'monaco':
        return 'lib/assets/images/circuits/Monaco.png';
      case 'villeneuve':
        return 'lib/assets/images/circuits/Montreal.png';
      case 'catalunya':
        return 'lib/assets/images/circuits/Spanje.png';
      case 'red_bull_ring':
        return 'lib/assets/images/circuits/Spielberg.png';
      case 'silverstone':
        return 'lib/assets/images/circuits/Silverstone.png';
      case 'hungaroring':
        return 'lib/assets/images/circuits/Hungaroring.png';
      case 'spa':
        return 'lib/assets/images/circuits/Spa.png';
      case 'zandvoort':
        return 'lib/assets/images/circuits/Zandvoort.png';
      case 'monza':
        return 'lib/assets/images/circuits/Monza.png';
      case 'baku':
        return 'lib/assets/images/circuits/Baku.png';
      case 'marina_bay':
        return 'lib/assets/images/circuits/Singapore.png';
      case 'americas':
        return 'lib/assets/images/circuits/Austin.png';
      case 'rodriguez':
        return 'lib/assets/images/circuits/Mexico.png';
      case 'interlagos':
        return 'lib/assets/images/circuits/Brazil.png';
      case 'vegas':
        return 'lib/assets/images/circuits/Vegas.png';
      case 'losail':
        return 'lib/assets/images/circuits/Qatar.png';
      case 'yas_marina':
        return 'lib/assets/images/circuits/Dubai.png';
      default:
        return 'lib/assets/images/circuits/Default.png';
    }
  }

  static Future<List<RaceData>> getCircuits() async {
    // Connectie met de api
    final responseCircuits =
        await http.get(Uri.parse('https://ergast.com/api/f1/current.json'));

    if (responseCircuits.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(responseCircuits.body);
      List<dynamic> races = data['MRData']['RaceTable']['Races'];

      // Een list waar alle data komt die nodig gaat zijn bij het afbeelden van de races
      List<RaceData> raceList = [];

      // For loop die alle data pakt per race
      for (var race in races) {
        String raceDate = race['date'];
        DateTime raceDateTime = DateTime.parse(raceDate);
        DateTime startDate = raceDateTime.subtract(const Duration(days: 2));

        List<String> weekendDates = List.generate(3, (index) {
          DateTime date = startDate.add(Duration(days: index));
          return DateFormat('d MMM').format(date);
        });

        if (weekendDates.length == 3) {
          weekendDates.removeAt(1);
        }

        raceList.add(RaceData(
          circuitnaam: race['Circuit']['circuitName'] ?? 'Onbekend Circuit',
          locatie:
              race['Circuit']['Location']['locality'] ?? 'Onbekende Locatie',
          land: race['Circuit']['Location']['country'] ?? 'Onbekend Land',
          raceDate: DateFormat('d MMM yyyy').format(raceDateTime),
          weekendDates: weekendDates,
          circuitImageAsset: getCircuitImageAsset(race['Circuit']['circuitId']),
        ));
      }

      return raceList;
    } else {
      // Voor het geval het niet lukt om een connectie met de api te krijgen
      throw Exception('Failed to load circuits');
    }
  }
}
