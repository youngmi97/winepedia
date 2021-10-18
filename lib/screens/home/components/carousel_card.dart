import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/details_screen.dart';
import 'package:winepedia/screens/home/components/asset_player_widget.dart';

import '../../../constants.dart';

class CarouselCard extends StatelessWidget {
  final WineBar wineBar;
  const CarouselCard({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedBuilder: (context, action) => buildCarouselCard(context),
        openBuilder: (context, action) => DetailsScreen(wineBar: wineBar));
  }

  Column buildCarouselCard(BuildContext context) => Column(
        children: <Widget>[
          wineBar.posterVideo.contains("mp4")
              ? Expanded(
                  child: Stack(
                      textDirection: TextDirection.ltr,
                      children: <Widget>[
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                                    begin: Alignment(0.0, 0.6),
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.white, Colors.black])
                                .createShader(bounds);
                          },
                          child: AssetPlayerWidget(
                              wineBar.posterVideo, wineBar.posterImage),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              Subheading(),
                              Description(),
                              GoToDeatilsPage()
                            ])
                      ]),
                )
              : Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [kDefaultShadow],
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(wineBar.posterImage)))))
        ],
      );
}

class Subheading extends StatelessWidget {
  const Subheading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            height: 20,
            margin: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(
              "가르고뜨",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )),
        Container(
            height: 20,
            margin: const EdgeInsets.only(left: 12),
            child: Text(
              "서울 / 서초구",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.white),
            )),
      ],
    );
  }
}

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: 8,
        ),
        width: 350,
        child: Text(
          "서초구에 위치한 혼술하기 좋은 와인바",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
        ));
  }
}

class GoToDeatilsPage extends StatelessWidget {
  const GoToDeatilsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            const EdgeInsets.only(left: kDefaultPadding, top: 10, bottom: 22),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.5),
        decoration: BoxDecoration(
            color: const Color(0x4DFFFFFF),
            borderRadius: BorderRadius.circular(17.5)),
        child: Text(
          "자세히 보기 >",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.normal, fontSize: 17, color: Colors.white),
        ));
  }
}
