import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  final WineBar wineBar;

  const DetailsScreen({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(wineBar: wineBar),
    );
  }
}
