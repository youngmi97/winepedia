import 'package:flutter/material.dart';
import 'package:winepedia/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          AppBar(backgroundColor: Colors.white, toolbarHeight: 0, elevation: 0),
      body: const Body(),
    );
  }
}
