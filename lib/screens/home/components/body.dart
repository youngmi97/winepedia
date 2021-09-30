import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/home/components/carousel_card.dart';
import '../../../constants.dart';
import 'dart:math' as math;

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Heading(),
        Carousel(),
        const Subheading(),
        const Description()
      ],
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        child: Text(
          "Wine Bars",
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 30),
        ));
  }
}

class Subheading extends StatelessWidget {
  const Subheading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(
                left: kDefaultPadding * 2, top: kDefaultPadding / 4),
            child: Text(
              "가르고뜨",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        Container(
            margin: const EdgeInsets.only(left: kDefaultPadding / 2),
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 4),
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(50)),
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
            left: kDefaultPadding * 2, top: kDefaultPadding / 4),
        width: 350,
        child: Text(
          "서초구에 위치한 혼술하기 좋은 와인바",
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
        ));
  }
}

class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  int initialPage = 1;

  @override
  void initState() {
    //so that we can small portion shown on left and right side
    super.initState();
    _pageController =
        PageController(viewportFraction: 0.8, initialPage: initialPage);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: AspectRatio(
            aspectRatio: 0.85,
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    initialPage = value;
                  });
                },
                controller: _pageController,
                itemCount: wineBars.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) => buildSlider(index))));
  }

  Widget buildSlider(int index) => AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = index - _pageController.page!;
          value = (value * 0.038).clamp(-1, 1);
        }
        return AnimatedOpacity(
          duration: Duration(milliseconds: 350),
          opacity: initialPage == index ? 1 : 0.4,
          child: Transform.rotate(
            angle: math.pi * value,
            child: CarouselCard(wineBar: wineBars[index]),
          ),
        );
      });
}
