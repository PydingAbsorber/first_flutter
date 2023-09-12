import 'package:first_flutter/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/pages/secondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SecondPage(title: 'Home'),
        '/todo': (context) => const Home(key: Key('Task List')),
      },
    );
  }
}


