import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';

class Body extends StatelessWidget {
  final WineBar wineBar;

  const Body({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it will provide us with total height and width
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      Container(
          height: size.height * 0.4,
          child: Stack(children: <Widget>[
            Container(
              height: size.height * 0.4 - 50,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(wineBar.poster))),
            ),
            SafeArea(child: BackButton()),
          ]))
    ]);
  }
}
