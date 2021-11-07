import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/models/custom_class.dart';
import 'package:winepedia/screens/details/details_screen.dart';
import 'package:winepedia/screens/home/components/asset_player_widget.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:winepedia/constants.dart';

import '../../../constants.dart';

class CarouselCard extends StatelessWidget {
  final int currentIndex;
  final int posterIndex;
  final ItemContext? barContent;
  final WineBar wineBar;
  CarouselCard(
      this.currentIndex, this.posterIndex, this.barContent, this.wineBar,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedElevation: 0,
        openElevation: 0,
        closedBuilder: (context, action) => buildCarouselCard(context),
        openBuilder: (context, action) =>
            DetailsScreen(barContent, wineBar: wineBar));
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
                          child: AssetPlayerWidget(currentIndex, posterIndex,
                              wineBar.posterVideo, wineBar.posterImage),
                        ),
                        barContent?.name == null
                            ? const SizedBox(width: 1)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Subheading(
                                        barContent?.name, barContent?.address),
                                    Description(barContent?.description),
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
  final String? barName;
  final String? address;
  const Subheading(this.barName, this.address, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 20,
            margin: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(
              '$barName',
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
              "$address",
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
  final String? description;
  const Description(this.description, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: 8,
        ),
        width: 350,
        child: Text(
          "$description",
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
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
                color: Colors.white),
            children: [
              TextSpan(
                text: "자세히 보기 ",
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(SFSymbols.chevron_right,
                    color: Colors.white, size: 20),
              ),
            ],
          ),
        ));
  }
}
