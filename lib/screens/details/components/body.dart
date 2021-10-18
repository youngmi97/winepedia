import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/components/scroll_screen.dart';

class Body extends StatelessWidget {
  final WineBar wineBar;
  const Body({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it will provide us with total height and width
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      SizedBox(
          height: size.height,
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    height: size.height * 0.4 - 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(wineBar.posterImage)))),
              ],
            ),
            const SafeArea(child: BackButton()),
            const ScrollScreen(),
          ])),
    ]);
  }
}
