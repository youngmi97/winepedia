import 'dart:io';

import 'package:flutter/gestures.dart';
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
          height: size.height,
          child: Stack(children: <Widget>[
            Container(
              height: size.height * 0.4 - 50,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(wineBar.poster))),
            ),
            const SafeArea(child: BackButton()),
            DraggableScrollableSheet(
                minChildSize: 0.7,
                maxChildSize: 1,
                initialChildSize: 0.7,
                builder: (context, controller) {
                  return SingleChildScrollView(
                      controller: controller,
                      child: SizedBox(
                          height: size.height,
                          child: Stack(children: <Widget>[
                            Container(
                                child: GestureDetector(
                                    onVerticalDragUpdate: (event) =>
                                        Navigator.pop(context)),
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(24),
                                        topRight: Radius.circular(24)))),
                          ])));
                }),
          ]))
    ]);
  }
}
