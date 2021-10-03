import 'package:flutter/material.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/screens/details/components/audio_player.dart';

class Body extends StatelessWidget {
  final WineBar wineBar;
  const Body({Key? key, required this.wineBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it will provide us with total height and width
    Size size = MediaQuery.of(context).size;
    double height = size.height;
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
                            image: AssetImage(wineBar.poster)))),
              ],
            ),
            const SafeArea(child: BackButton()),
            NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  print(notification.extent);
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
                              height: size.height,
                              child: Stack(children: <Widget>[
                                Container(
                                    // child: GestureDetector(
                                    //     onVerticalDragDown: (event) =>
                                    //         Navigator.pop(context)),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(24),
                                            topRight: Radius.circular(24)))),
                              ])));
                    })),
            Container(
                child: Column(children: <Widget>[
              SizedBox(height: size.height * 0.4 - 50),
              const Subheading(),
              const Description(),
              const Divider(
                height: 28,
                thickness: 1,
                indent: kDefaultPadding * 2,
                endIndent: kDefaultPadding * 2,
              ),
              const SommelierPhoto(),
              AudioPlayerLocalAsset(),
            ]))
          ])),
    ]);
  }
}

class Subheading extends StatelessWidget {
  const Subheading({Key? key});

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
        margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        width: 350,
        child: Text(
          "Name of Bar",
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
        ));
  }
}

class SommelierPhoto extends StatelessWidget {
  const SommelierPhoto({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        height: 60.0,
        width: 60.0,
        margin: const EdgeInsets.only(left: kDefaultPadding * 2, right: 0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sommelier.jpg'),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.circle,
        ),
      ),
      Column(children: <Widget>[
        Container(
            width: 275,
            margin: const EdgeInsets.only(
                left: kDefaultPadding, bottom: kDefaultPadding / 2, right: 0),
            child: Text(
              "김유진 소믈리에",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
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
      ])
    ]);
  }
}
