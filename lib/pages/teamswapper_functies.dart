import 'package:flutter/material.dart';
import 'dart:math';

class TeamswapperFuncties {
  // Functie die ervoor zorgt dat er willekeurige coureurs bij een team worden gezet als je op de 'willekeurig toewijzen' knop klik
  static void randomCoureurs(droppedImage, drivers) {
    List<int> beschikbarePosities = List.generate(20, (index) => index);

    // loopt door de lijst met coureurs en plaats deze op een willekeurige positie in de nieuwe lijst beschikbare posities
    for (var driver in drivers) {
      int randomIndex = Random().nextInt(beschikbarePosities.length);
      int index = beschikbarePosities[randomIndex];
      beschikbarePosities.removeAt(randomIndex);
      droppedImage[index] = driver['image'];
      driver['isVisible'] = false;
    }
  }

  static void simuleerKampioenschap(droppedImage, racingteams, drivers) {
    List<Map<String, dynamic>> positie = [];

    // bereken de scores van de driver list op basis van het team waar ze ingedeeld zijn
    for (var driver in drivers) {
      if (!driver['isVisible']) {
        double teamElo = 0;
        int driverIndex = droppedImage.indexOf(driver['image']);

        // pakt de elo van het juiste team waarbij de driver wordt ingedeeld
        teamElo = racingteams[driverIndex ~/ 2]['ELO'];

        // Bereken de totale score
        double totaleElo = driver['ELO'] + teamElo;
        positie.add({'name': driver['name'], 'totaleElo': totaleElo});
      }
    }
    positie.sort((a, b) => b['totaleElo'].compareTo(a['totaleElo']));
    for (int i = 0; i < positie.length; i++) {
      positie[i]['positie'] = i + 1;
    }

    for (var driver in drivers) {
      for (var plek in positie) {
        if (driver['name'] == plek['name']) {
          driver['positie'] = plek['positie'];
          print('${driver['name']} ${driver['positie']}');
        }
      }
    }
  }

  // Functie om alle coureurs te resetten naar de grid
  static List<Map<String, dynamic>> resetDrivers() {
    return [
      {
        'name': 'Max Verstappen',
        'image': Image.asset('lib/assets/images/drivers/Max.png'),
        'isVisible': true,
        'ELO': 32.98
      },
      {
        'name': 'Sergio Perez',
        'image': Image.asset('lib/assets/images/drivers/Sergio.png'),
        'isVisible': true,
        'ELO': 29.97
      },
      {
        'name': 'Charles Leclerc',
        'image': Image.asset('lib/assets/images/drivers/Charles.png'),
        'isVisible': true,
        'ELO': 30.54
      },
      {
        'name': 'Carlos Sainz',
        'image': Image.asset('lib/assets/images/drivers/Carlos.png'),
        'isVisible': true,
        'ELO': 29.16
      },
      {
        'name': 'Lewis Hamilton',
        'image': Image.asset('lib/assets/images/drivers/Lewis.png'),
        'isVisible': true,
        'ELO': 32.98
      },
      {
        'name': 'George Russel',
        'image': Image.asset('lib/assets/images/drivers/George.png'),
        'isVisible': true,
        'ELO': 26.53
      },
      {
        'name': 'Oscar Piastri',
        'image': Image.asset('lib/assets/images/drivers/Oscar.png'),
        'isVisible': true,
        'ELO': 27.00
      },
      {
        'name': 'Lando Norris',
        'image': Image.asset('lib/assets/images/drivers/Lando.png'),
        'isVisible': true,
        'ELO': 28.16
      },
      {
        'name': 'Fernando Alonso',
        'image': Image.asset('lib/assets/images/drivers/Fernando.png'),
        'isVisible': true,
        'ELO': 28.90
      },
      {
        'name': 'Lance Stroll',
        'image': Image.asset('lib/assets/images/drivers/Lance.png'),
        'isVisible': true,
        'ELO': 27.59
      },
      {
        'name': 'Daniel Ricciardo',
        'image': Image.asset('lib/assets/images/drivers/Daniel.png'),
        'isVisible': true,
        'ELO': 30.50
      },
      {
        'name': 'Yuki Tsunoda',
        'image': Image.asset('lib/assets/images/drivers/Yuki.png'),
        'isVisible': true,
        'ELO': 26.75
      },
      {
        'name': 'Nico Hülkenberg',
        'image': Image.asset('lib/assets/images/drivers/Nico.png'),
        'isVisible': true,
        'ELO': 28.65
      },
      {
        'name': 'Kevin Magnussen',
        'image': Image.asset('lib/assets/images/drivers/Kevin.png'),
        'isVisible': true,
        'ELO': 27.90
      },
      {
        'name': 'Esteban Ocon',
        'image': Image.asset('lib/assets/images/drivers/Esteban.png'),
        'isVisible': true,
        'ELO': 28.61
      },
      {
        'name': 'Pierre Gasly',
        'image': Image.asset('lib/assets/images/drivers/Pierre.png'),
        'isVisible': true,
        'ELO': 28.80
      },
      {
        'name': 'Alexander Albon',
        'image': Image.asset('lib/assets/images/drivers/Alex.png'),
        'isVisible': true,
        'ELO': 29.21
      },
      {
        'name': 'Logan Sargeant',
        'image': Image.asset('lib/assets/images/drivers/Logan.png'),
        'isVisible': true,
        'ELO': 26.25
      },
      {
        'name': 'Valterri Bottas',
        'image': Image.asset('lib/assets/images/drivers/Valterri.png'),
        'isVisible': true,
        'ELO': 31.90
      },
      {
        'name': 'Guanyu Zhou',
        'image': Image.asset('lib/assets/images/drivers/Guanyu.png'),
        'isVisible': true,
        'ELO': 26.50
      },
    ];
  }
}
