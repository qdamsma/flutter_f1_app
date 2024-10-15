import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_f1_app/services/teamswapper_data.dart';


class Teamswapper extends StatefulWidget {
  @override
  State<Teamswapper> createState() => _TeamswapperState();
}

class _TeamswapperState extends State<Teamswapper> {
  bool coureursZichtbaarheid = true;
  bool overzicht = false;
  int selectedIndex = 1;
  List<Image?> droppedImage = List.generate(20, (index) => null);

  // Functie om alle coureurs te resetten naar de grid
  void resetKnop(){
    setState(() {
      droppedImage = List.generate(20, (index) => null);
      drivers = [
    {'name': 'Max Verstappen', 'image': Image.asset('lib/assets/images/drivers/Max.png'), 'isVisible': true, 'ELO' : 32.98},
    {'name': 'Sergio Perez','image': Image.asset('lib/assets/images/drivers/Sergio.png'), 'isVisible': true, 'ELO' : 29.97},
    {'name': 'Charles Leclerc','image': Image.asset('lib/assets/images/drivers/Charles.png'), 'isVisible': true, 'ELO' : 30.54},
    {'name': 'Carlos Sainz','image': Image.asset('lib/assets/images/drivers/Carlos.png'), 'isVisible': true, 'ELO' : 29.16},
    {'name': 'Lewis Hamilton','image': Image.asset('lib/assets/images/drivers/Lewis.png'), 'isVisible': true, 'ELO' : 32.98},
    {'name': 'George Russel','image': Image.asset('lib/assets/images/drivers/George.png'), 'isVisible': true, 'ELO' : 26.53},
    {'name': 'Oscar Piastri','image': Image.asset('lib/assets/images/drivers/Oscar.png'), 'isVisible': true, 'ELO' : 27.00},
    {'name': 'Lando Norris','image': Image.asset('lib/assets/images/drivers/Lando.png'), 'isVisible': true, 'ELO' : 28.16},
    {'name': 'Fernando Alonso','image': Image.asset('lib/assets/images/drivers/Fernando.png'), 'isVisible': true, 'ELO' : 28.90},
    {'name': 'Lance Stroll','image': Image.asset('lib/assets/images/drivers/Lance.png'), 'isVisible': true, 'ELO' : 27.59},
    {'name': 'Daniel Ricciardo','image': Image.asset('lib/assets/images/drivers/Daniel.png'), 'isVisible': true, 'ELO' : 30.50},
    {'name': 'Yuki Tsunoda','image': Image.asset('lib/assets/images/drivers/Yuki.png'), 'isVisible': true, 'ELO' : 26.75},
    {'name': 'Nico Hülkenberg','image': Image.asset('lib/assets/images/drivers/Nico.png'), 'isVisible': true, 'ELO' : 28.65},
    {'name': 'Kevin Magnussen','image': Image.asset('lib/assets/images/drivers/Kevin.png'), 'isVisible': true, 'ELO' : 27.90},
    {'name': 'Esteban Ocon','image': Image.asset('lib/assets/images/drivers/Esteban.png'), 'isVisible': true, 'ELO' : 28.61},
    {'name': 'Pierre Gasly','image': Image.asset('lib/assets/images/drivers/Pierre.png'), 'isVisible': true, 'ELO' : 28.80},
    {'name': 'Alexander Albon','image': Image.asset('lib/assets/images/drivers/Alex.png'), 'isVisible': true, 'ELO' : 29.21},
    {'name': 'Logan Sargeant','image': Image.asset('lib/assets/images/drivers/Logan.png'), 'isVisible': true, 'ELO' : 26.25},
    {'name': 'Valterri Bottas','image': Image.asset('lib/assets/images/drivers/Valterri.png'), 'isVisible': true, 'ELO' : 31.90},
    {'name': 'Guanyu Zhou','image': Image.asset('lib/assets/images/drivers/Guanyu.png'), 'isVisible': true, 'ELO' : 26.50},
  ];
    });
  }

  // Functie die ervoor zorgt dat er willekeurige coureurs bij een team worden gezet als je op de 'willekeurig toewijzen' knop klik
  void randomCoureurs() {
    setState(() {
      List<int> beschikbarePosities = List.generate(20, (index) => index);
      
      // loopt door de lijst met coureurs en plaats deze op een willekeurige positie in de nieuwe lijst beschikbare posities
      for (var driver in drivers) {
        int randomIndex = Random().nextInt(beschikbarePosities.length);
        int index = beschikbarePosities[randomIndex];
        beschikbarePosities.removeAt(randomIndex);
        droppedImage[index] = driver['image'];
        driver['isVisible'] = false;
      }
    });
  }
  
  //Functie die de onderste grid aan coureurs zichtbaar maakt en verbergt, zodat er meer overzicht is
  void verbergCoureurs() {
  setState(() {
    coureursZichtbaarheid = !coureursZichtbaarheid;
  });
  }

  // Functie om de bottomnavigation te laten werken
  void onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        break;
    }
  }

  
  // Functie om het kampioenschap van een echt F1 seizoen te laten simuleren
  void simuleerKampioenschap() {
  setState(() {
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
    for(int i = 0; i < positie.length; i++){
      positie[i]['positie'] = i + 1;
    }

    for (var driver in drivers) {
      for (var plek in positie) {
        if (driver['name'] == plek['name']) {
          driver['positie'] = plek['positie'];
          overzicht = true;
          print('${driver['name']} ${driver['positie']}');
        }
      }
    }

  }
  );
}

Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Overzicht Simulatie'),
        content: SingleChildScrollView(
          child: ListBody(
            children: drivers.map((driver){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(driver['name']),
                    Text(driver['positie'].toString()),
                  ],
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Terug'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  // Build van de pagina
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teamswapper', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF1E00),
      ),
      body: Column(
        children: [
          // Buttons voor verschillende functies op de pagina
          ElevatedButton(
            onPressed: randomCoureurs,
            child: Text("Willekeurig toewijzen"),
          ),
          ElevatedButton(
            onPressed: resetKnop,
            child: Text("Reset"),
          ),
          ElevatedButton(
            onPressed: verbergCoureurs,
            child: Text(coureursZichtbaarheid ? "Verberg Coureurs" : "Toon Coureurs"),
          ),
          ElevatedButton(
            onPressed: simuleerKampioenschap,
            child: Text("Simuleer Kampioenschap"),
          ),
          if (overzicht == true)
          ElevatedButton(
            onPressed: _showMyDialog,
            child: Text("Overzicht"),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1 / 1.1,),
                  itemCount: racingteams.length,
                  itemBuilder: (context, index) {
                    final team = racingteams[index];
                    return Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: team['image'],
                            ),
                          ),
                          Text(
                            team['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dragTargetMaken(
                                  index * 2), 
                              dragTargetMaken(
                                  index * 2 + 1), 
                            ],
                          ),
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //contoleer of een afbeelding is gedropt voor de 1e coureur 
                              Text(
                                droppedImage[index * 2] != null
                                    ? getPositie(droppedImage[index * 2])
                                    : "",
                              ),
                              //contoleer of een afbeelding is gedropt voor de 2e coureur 
                              Text(
                                droppedImage[index * 2 + 1] != null
                                    ? getPositie(droppedImage[index * 2 + 1])
                                    : "",
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )),
              // Als de toon coureurs knop op toon staat, laat hij de coureurs grid zien
          if (coureursZichtbaarheid == true)
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: drivers.length,
                  itemBuilder: (context, index) {
                    final driver = drivers[index];
                    if (!driver['isVisible']) return const SizedBox();
                    return Draggable<Image>(
                      data: driver['image'],
                      feedback: Container(
                        height: 100,
                        width: 100,
                        color: Colors.blueAccent,
                        child: Center(child: driver['image']),
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: driver['image']),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_calls),
            label: 'Teamswapper',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }

  String getPositie(Image ?image){
    // kijkt in de drivers list of de image hetzelfde is als de gedropte image en of de list een positie bevat zodat het de positie kan terug geven
    for (var driver in drivers){
      if(driver['image'] == image && driver.containsKey('positie')){
        return 'P${driver['positie']}';
      }
    }
    return '';
  }

  // Widget voor de targets in een card
  Widget dragTargetMaken(int index) {
    return DragTarget<Image>(onWillAcceptWithDetails: (details) {
      return droppedImage[index] == null;
    }, onAcceptWithDetails: (details) {
      setState(() {
        droppedImage[index] = details.data;
        for (var driver in drivers) {
          if (driver['image'] == details.data) {
            driver['isVisible'] = false;
            break;
          }
        }
      });
    }, builder:
        (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
      return Container(
        height: 53,
        width: 53,
        color: const Color.fromARGB(255, 228, 233, 231),
        child: Center(
          child: droppedImage[index] ?? Text('Plaats hier'),
        ),
      );
    });
  }
}
