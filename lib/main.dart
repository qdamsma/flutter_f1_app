import 'package:flutter/material.dart';
import 'package:flutter_f1_app/pages/loading.dart';
import 'package:flutter_f1_app/pages/mainpage.dart';
import 'package:flutter_f1_app/pages/detailpage.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'F1Font',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => MainPage(),
        '/circuit_detail': (context) => const CircuitDetailPage(),
      },
    ));
