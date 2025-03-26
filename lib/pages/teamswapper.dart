import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_f1_app/pages/teamswapper_functies.dart';
import 'package:flutter_f1_app/services/teamswapper_data.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Teamswapper extends StatefulWidget {
  const Teamswapper({super.key});

  @override
  State<Teamswapper> createState() => _TeamswapperState();
}

class _TeamswapperState extends State<Teamswapper> {
  List<Image?> droppedImage = List.generate(20, (index) => null);

  bool canSimulate = true;
  StreamSubscription? shakeListener;

  @override
  void initState() {
    super.initState();
    startShakeDetection();
  }

  void startShakeDetection() {
    shakeListener = accelerometerEventStream().listen((event) {
      double acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;

      if (acceleration > 1500 && canSimulate) {
        triggerSimulation();
      }
    });
  }

  void triggerSimulation() {
    setState(() {
      canSimulate = false;
      simuleerKampioenschap();
    });

    // Cooldown van 5 seconden voordat je opnieuw kunt schudden
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        canSimulate = true;
      });
    });
  }

  Future<void> uitlegKnop() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uitleg Teamswapper'),
          content: const Text(
              'Teamswapper is een simulatie om het f1 seizoen van 2024 na te simuleren. Op de pagina zie je alle coureurs en teams van het F1 seizoen van 2024. Sleep coureurs naar een team naar keuze en klik op "Simuleer". \n\n'
              'De simulatie is gebaseerd op een formule met een vorm van willekeurigheid om de simulatie elke keer een andere uitslag te geven, uiteraard is er rekening gehouden met de skills van de coureur. \n\n'
              'Veel plezier en bedenk de gekste combinaties.'),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Haalt reset functie op uit teamswapper_functies
  void resetKnop() {
    setState(() {
      droppedImage = List.generate(20, (index) => null);
      drivers = TeamswapperFuncties.resetDrivers();
    });
  }

  bool coureursZichtbaarheid = true;
  bool overzicht = false;

  // Haalt randomCoureurs functie op uit teamswapper_functies
  void randomCoureurs() {
    setState(() {
      TeamswapperFuncties.randomCoureurs(droppedImage, drivers);
    });
  }

  //Functie die de onderste grid aan coureurs zichtbaar maakt en verbergt, zodat er meer overzicht is
  void verbergCoureurs() {
    setState(() {
      coureursZichtbaarheid = !coureursZichtbaarheid;
    });
  }

  // Functie om het kampioenschap van een echt F1 seizoen te laten simuleren
  void simuleerKampioenschap() {
    setState(() {
      TeamswapperFuncties.simuleerKampioenschap(
          droppedImage, racingteams, drivers);
      overzicht = true;
    });
  }

  Future<void> overzichtSimulatie() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Overzicht Simulatie'),
          content: SingleChildScrollView(
            child: ListBody(
              children: drivers.map((driver) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/assets/images/f1_logo_app.png', height: 40),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 203, 29, 6),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: 155,
                child: ElevatedButton(
                  onPressed: uitlegKnop,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Uitleg"), Icon(Icons.help)],
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: randomCoureurs,
                  child: const Text("Willekeurig toewijzen",
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: resetKnop,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Reset ",
                        textAlign: TextAlign.center,
                      ),
                      Icon(Icons.restore)
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: verbergCoureurs,
                  child: Align(
                    child: Text(
                      coureursZichtbaarheid
                          ? "Verberg Coureurs"
                          : "Toon Coureurs",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              if (overzicht == true)
                SizedBox(
                  width: 155,
                  child: ElevatedButton(
                    onPressed: overzichtSimulatie,
                    child: const Row(
                      children: [Text("Overzicht "), Icon(Icons.visibility)],
                    ),
                  ),
                ),
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  "Schud je telefoon om het kampioenschap te simuleren!",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio:
                        MediaQuery.of(context).size.width > 600 ? 2.1 : 1 / 1.1,
                  ),
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
                              dragTargetMaken(index * 2),
                              dragTargetMaken(index * 2 + 1),
                            ],
                          ),
                          const SizedBox(height: 10),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 8 : 4,
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
                            color: Color.fromARGB(255, 203, 29, 6),
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
    );
  }

  String getPositie(Image? image) {
    // kijkt in de drivers list of de image hetzelfde is als de gedropte image
    // en of de list een positie bevat zodat het de positie kan terug geven
    for (var driver in drivers) {
      if (driver['image'] == image && driver.containsKey('positie')) {
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
          child: droppedImage[index] ?? const Text('Plaats hier'),
        ),
      );
    });
  }
}
