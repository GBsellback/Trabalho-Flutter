import 'package:flutter/material.dart';
import 'map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MapScreen(),
    );
  }
}
