import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/screens/details/components/wine_catalogue.dart';

class Scroll_Screen extends StatelessWidget {
  const Scroll_Screen({Key? key}) : super(key: key);
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
      const SommelierProfile(),
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
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      )),
    ]);
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

class SommelierProfile extends StatelessWidget {
  const SommelierProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Column(
        children: <Widget>[
          Container(
              width: 275,
              margin: const EdgeInsets.only(
                  left: kDefaultPadding, bottom: kDefaultPadding / 2),
              child: Text(
                "김유진 오너",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
              )),
          Container(
              margin: const EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                "처음 오는 손님께 주로 권해드리는 카르보네 \n소비뇽, 라비에이유 페름루즈, 마샤렐리 입니다.",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
              )),
        ],
      ),
      Container(
        height: 60.0,
        width: 60.0,
        margin: const EdgeInsets.only(left: kDefaultPadding),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sommelier.jpg'),
          ),
        ),
      ),
    ]);
  }
}

class WineList extends StatelessWidget {
  const WineList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
