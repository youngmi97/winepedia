import 'package:flutter/material.dart';
import 'package:winepedia/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget  {
  // HomeScreen({Key? key}) : super(key: key)
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Body(),
    );
  }
}

