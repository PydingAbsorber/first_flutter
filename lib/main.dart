import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter/pages/home.dart';
import 'package:first_flutter/pages/profile.dart';
import 'package:first_flutter/pages/profilePage.dart';
import 'package:first_flutter/pages/shop.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/pages/secondPage.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
      initialRoute: '/shop',
      routes: {
        '/shop': (context) => const Shop(key: Key('Shop'), title: 'Shop',),
        '/profile': (context) => const AuthPage(key: Key('Profile'),),
      },
    );
  }
}


