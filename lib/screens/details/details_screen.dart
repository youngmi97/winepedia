import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/components/body.dart';
import 'package:flutter/services.dart';

class DetailsScreen extends StatelessWidget {
  final WineBar wineBar;

  const DetailsScreen({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Use [SystemUiOverlayStyle.light] for white status bar
      // or [SystemUiOverlayStyle.dark] for black status bar
      // https://stackoverflow.com/a/58132007/1321917
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Body(wineBar: wineBar),
      ),
    );
  }
}
