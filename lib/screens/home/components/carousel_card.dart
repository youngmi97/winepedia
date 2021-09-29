import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/details_screen.dart';
import '../../../constants.dart';

class CarouselCard extends StatelessWidget {
  final WineBar wineBar;

  const CarouselCard({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: OpenContainer(
            closedElevation: 0,
            openElevation: 0,
            closedBuilder: (context, action) => buildCarouselCard(context),
            openBuilder: (context, action) => DetailsScreen(wineBar: wineBar)));
  }

  Column buildCarouselCard(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [kDefaultShadow],
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(wineBar.poster)))),
      )
    ]);
  }
}
