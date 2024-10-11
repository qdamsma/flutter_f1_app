import 'package:flutter/material.dart';
import 'package:flutter_f1_app/pages/home.dart';
import 'package:flutter_f1_app/pages/loading.dart';
import 'package:flutter_f1_app/pages/teamswapper.dart';
import 'package:flutter_f1_app/pages/detailpage.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    fontFamily: 'F1Font',
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => F1_Home(),
    '/teamswapper': (context) => Teamswapper(),
    '/circuit_detail': (context) => CircuitDetailPage(),
  },
));

