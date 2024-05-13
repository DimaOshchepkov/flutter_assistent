//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.greenAccent,
        cardColor: Colors.blueAccent,
        useMaterial3: true,
      ),
      home: const Home(),
    ));
}