<<<<<<< HEAD
//@dart=2.9
=======
// @dart=2.9
>>>>>>> e0a3e87028ef134dc9cf8b0b18a3a93db33f6da6
import 'package:flutter/material.dart';
import 'package:winepedia/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
  //const MyApp({Key? key}) : super(key: key);
=======
  const MyApp({Key key}) : super(key: key);
>>>>>>> e0a3e87028ef134dc9cf8b0b18a3a93db33f6da6

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Winebar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
