import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/screens/details/components/wine_catalogue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          if (notification.extent < 0.7) {
            Navigator.maybePop(context);
            return true;
          } else {
            return true;
          }
        },
        child: DraggableScrollableSheet(
            minChildSize: 0.6,
            maxChildSize: 1,
            initialChildSize: 0.7,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
                child: SizedBox(
                  height: 985.6,
                  child: Stack(children: <Widget>[
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)))),
                    ScrollScreenStart(),
                  ]),
                ),
              );
            }));
  }
}

class ScrollScreenStart extends StatelessWidget {
  ScrollScreenStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String addr = "서울 서초구 효령로77길 34 아크로텔 116호";
    return Column(children: <Widget>[
      const SizedBox(height: 36),
      const Subheading(),
      const Description(),
      const Divider(
        height: 56,
        thickness: 1,
        indent: kDefaultPadding,
        endIndent: kDefaultPadding,
      ),
      WineBarAddress(addr),
      WineBarTime(),
      WineBarInsta(),
      const Divider(
        height: 56,
        thickness: 1,
        indent: kDefaultPadding,
        endIndent: kDefaultPadding,
      ),
      Container(
          width: size.width,
          margin: const EdgeInsets.only(
              left: kDefaultPadding, top: kDefaultPadding / 4),
          child: Text(
            "추천 와인",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          )),
      Expanded(
          child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: Colors.white,
            bottom: const TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                  text: "레드",
                ),
                Tab(
                  text: "화이트",
                ),
                Tab(
                  text: "로제",
                ),
                Tab(
                  text: "스파클링",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              WineCatalogue(),
              FaIcon(FontAwesomeIcons.instagram),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      )),
    ]);
  }
}

class WineBarAddress extends StatelessWidget {
  WineBarAddress(this.addr, {Key? key}) : super(key: key);
  final String addr;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(left: kDefaultPadding),
            child: FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 15)),
        Container(
            height: 15,
            margin: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              addr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            )),
      ],
    );
  }
}

class WineBarTime extends StatelessWidget {
  const WineBarTime({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: kDefaultPadding),
        child: Row(
          children: <Widget>[
            Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.only(left: kDefaultPadding),
                child: FaIcon(FontAwesomeIcons.clock, size: 15)),
            Container(
                height: 45,
                margin: const EdgeInsets.only(left: kDefaultPadding / 2),
                child: Text(
                  "수요일 17:00~22:00",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
                )),
          ],
        ));
  }
}

class WineBarInsta extends StatelessWidget {
  const WineBarInsta({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(
                left: kDefaultPadding, top: kDefaultPadding),
            child: FaIcon(FontAwesomeIcons.clock, size: 15)),
        Container(
            height: 45,
            margin: const EdgeInsets.only(
                left: kDefaultPadding / 2, top: kDefaultPadding),
            child: Text(
              "instagram address",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
            )),
      ],
    );
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
                left: kDefaultPadding, top: kDefaultPadding / 4),
            child: Text(
              "가르고뜨",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 17),
            )),
        Container(
            margin: const EdgeInsets.only(left: kDefaultPadding / 2),
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 6),
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
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(left: kDefaultPadding, top: 12),
        width: width,
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
