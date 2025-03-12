import 'package:flutter/material.dart';
import 'package:empty/cat/bemen3/dam/m8/uf1/p3b/serveis/model/Exercici4/views/jokeScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const JokeScreen(),
    );
  }
}