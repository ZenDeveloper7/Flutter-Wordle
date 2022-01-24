import 'package:flutter/material.dart';
import 'package:flutter_wordle/ui/Details.dart';
import 'package:flutter_wordle/ui/Home.dart';
import 'package:flutter_wordle/ui/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wordle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: TextTheme(button: TextStyle(fontSize: 18.0))),
      home: const Details(),
    );
  }
}
