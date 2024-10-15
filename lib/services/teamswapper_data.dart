import 'package:flutter/material.dart';

// Lijst met data voor coureurs
List<Map<String, dynamic>> drivers = [
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

// Lijst aan Formule 1 teams, met bijbehorende ELO
List<Map<String, dynamic>> racingteams = [
  {
    'name': 'RedBull Racing',
    'image': Image.asset('lib/assets/images/teams/RedBull.jpg'),
    'isVisible': true,
    'ELO': 36.00
  },
  {
    'name': 'Mclaren',
    'image': Image.asset('lib/assets/images/teams/Mclaren.jpg'),
    'isVisible': true,
    'ELO': 35.00
  },
  {
    'name': 'Ferrari',
    'image': Image.asset('lib/assets/images/teams/Ferrari.jpg'),
    'isVisible': true,
    'ELO': 35.00
  },
  {
    'name': 'Mercedes',
    'image': Image.asset('lib/assets/images/teams/Mercedes.jpg'),
    'isVisible': true,
    'ELO': 34.00
  },
  {
    'name': 'Aston Martin',
    'image': Image.asset('lib/assets/images/teams/AstonMartin.jpg'),
    'isVisible': true,
    'ELO': 33.00
  },
  {
    'name': 'Alpine',
    'image': Image.asset('lib/assets/images/teams/Alpine.jpg'),
    'isVisible': true,
    'ELO': 32.00
  },
  {
    'name': 'RB',
    'image': Image.asset('lib/assets/images/teams/RB.jpg'),
    'isVisible': true,
    'ELO': 31.50
  },
  {
    'name': 'Kick Sauber',
    'image': Image.asset('lib/assets/images/teams/KickSauber.jpg'),
    'isVisible': true,
    'ELO': 31.00
  },
  {
    'name': 'Williams',
    'image': Image.asset('lib/assets/images/teams/Williams.jpg'),
    'isVisible': true,
    'ELO': 31.25
  },
  {
    'name': 'Haas',
    'image': Image.asset('lib/assets/images/teams/Haas.jpg'),
    'isVisible': true,
    'ELO': 31.00
  },
];
