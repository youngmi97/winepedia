import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/screens/details/components/wine_catalogue.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScrollScreen extends StatefulWidget {
  ScrollScreen({Key? key}) : super(key: key);
  @override
  ScrollScreenState createState() => ScrollScreenState();
}

class ScrollScreenState extends State<ScrollScreen> {
  bool visibility = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          print(notification.extent);
          if (notification.extent >= 0.95) {
            setState(() {
              visibility = true;
            });
            return true;
          } else {
            setState(() {
              visibility = false;
            });
          }

          if (notification.extent < 0.7) {
            Navigator.maybePop(context);
            return true;
          } else {
            return true;
          }
        },
        child: Stack(children: [
          DraggableScrollableSheet(
              minChildSize: 0.6,
              maxChildSize: 1,
              initialChildSize: 0.7,
              builder: (context, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: SizedBox(
                    height: 1095.6,
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
              }),
          Visibility(
              child: Stack(children: <Widget>[
                Container(
                    height: 117,
                    width: size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                            image:
                                AssetImage("assets/images/bar_template.jpg")))),
                Container(
                    height: 117,
                    margin: const EdgeInsets.only(top: 40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0D000000),
                          spreadRadius: 2,
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Column(children: <Widget>[
                      Stack(children: [
                        const SizedBox(height: 36),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          height: 4,
                          width: 48,
                          decoration: const BoxDecoration(
                              color: Color(0x543C3C43),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(999))),
                        )
                      ]),
                      const Subheading(),
                      const Description(),
                    ]))
              ]),
              visible: visibility),
        ]));
  }
}

class ScrollScreenStart extends StatelessWidget {
  ScrollScreenStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String addr = "서울 서초구 효령로77길 34 아크로텔 116호";
    return Column(children: <Widget>[
      Stack(children: [
        const SizedBox(height: 36),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 4,
          width: 48,
          decoration: const BoxDecoration(
              color: Color(0x543C3C43),
              borderRadius: BorderRadius.all(Radius.circular(999))),
        )
      ]),
      const Subheading(),
      const Description(),
      const Divider(
        height: 56,
        thickness: 1,
        indent: kDefaultPadding,
        endIndent: kDefaultPadding,
      ),
      WineBarAddress(addr),
      WineBarOpen(),
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
            width: 30,
            height: 30,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: kDefaultPadding),
            child: FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 15)),
        Container(
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

class WineBarOpen extends StatelessWidget {
  const WineBarOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime date = DateTime.now();
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 13.5, left: kDefaultPadding),
            child: const FaIcon(FontAwesomeIcons.clock, size: 15)),
        Expanded(
          child: ListTileTheme(
              contentPadding: EdgeInsets.only(left: kDefaultPadding / 2),
              child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                    secondaryHeaderColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    backgroundColor: Colors.transparent,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    initiallyExpanded: false,
                    //childrenPadding: EdgeInsets.all(16),
                    title: TimeOpen(date.weekday - 1),
                    children: [
                      TimeOpen(0),
                      TimeOpen(1),
                      TimeOpen(2),
                      TimeOpen(3),
                      TimeOpen(4),
                      TimeOpen(5),
                      TimeOpen(6),
                    ],
                  ))),
        )
      ],
    ));
  }
}

class TimeOpen extends StatelessWidget {
  TimeOpen(this.date, {Key? key}) : super(key: key);
  final int date;
  final List<String> openHours = [
    "월요일 17:00~22:00",
    "화요일 17:00~22:00",
    "수요일 17:00~22:00",
    "목요일 17:00~22:00",
    "금요일 17:00~22:00",
    "토요일 휴무",
    "일요일 휴무",
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 30 - 2 * kDefaultPadding,
      //margin: const EdgeInsets.only(left: kDefaultPadding / 2),
      child: Text(
        openHours[date],
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
      ),
    );
  }
}

class WineBarInsta extends StatelessWidget {
  const WineBarInsta({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: const EdgeInsets.only(top: kDefaultPadding),
        child: Row(
      children: <Widget>[
        Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: kDefaultPadding),
            child: const FaIcon(FontAwesomeIcons.instagram, size: 15)),
        Container(
            margin: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: Text(
              "instagram address",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            )),
      ],
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

// class TextTilePage extends StatefulWidget {
//   @override
//   _TextTilePageState createState() => _TextTilePageState();
// }

// class _TextTilePageState extends State<TextTilePage> {
//   static final double radius = 20;

//   bool isExpanded = false;

//   Widget buildText(BuildContext context) => Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           initiallyExpanded: isExpanded,
//           childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
//           title: Text(
//             '👩 Sarah Pepperstone',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//           ),
//           children: [
//             Text(
//               'My name is Sarah and I am a New York City based Flutter developer. I help entrepreneurs & businesses figure out how to build scalable applications.\n\nWith over 7 years experience spanning across many industries from B2B to B2C, I live and breath Flutter.',
//               style: TextStyle(fontSize: 18, height: 1.4),
//             ),
//           ],
//         ),
//       );
// }
