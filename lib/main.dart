import 'package:flutter/material.dart';
import 'package:testktn/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    // home: Home(),

    routes: {
      '/': (context) => Home(),
    },
  ));
}
