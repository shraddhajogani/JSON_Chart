import 'package:flutter/material.dart';
import 'saleshomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: SalesHomePage(),
    );
  }
}
