import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/details_screen.dart';
import 'package:winepedia/screens/home/components/asset_player_widget.dart';

import '../../../constants.dart';
import 'package:video_player/video_player.dart';

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
            closedBuilder: (context, action) => AssetPlayerWidget(),
            openBuilder: (context, action) => DetailsScreen(wineBar: wineBar)));
  }

  Column buildCarouselCard(BuildContext context) => Column(
        children: <Widget>[
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [kDefaultShadow],
            ),
            child: AssetPlayerWidget(),
          ))
        ],
      );
  Widget buildAssets() => AssetPlayerWidget();
}
