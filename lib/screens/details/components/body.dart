import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';

import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/details/components/scroll_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatelessWidget {
  final String? phoneNumber;
  final WineBar wineBar;
  const Body(this.phoneNumber, {Key? key, required this.wineBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it will provide us with total height and width
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      SizedBox(
          height: size.height,
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    width: size.width,
                    height: size.height * 0.4 - 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                            image: AssetImage(wineBar.posterImage)))),
              ],
            ),
            //const SafeArea(child: BackButton()),
            const ScrollScreen(),
          ])),
      Positioned(
          bottom: 0,
          left: 0,
          child: Container(
              width: size.width,
              height: 110,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26000000),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: GestureDetector(
                  onTap: () {
                    print(phoneNumber);
                    launch("tel:$phoneNumber");
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.only(
                          left: kDefaultPadding, right: kDefaultPadding),
                      width: size.width - (2 * kDefaultPadding),
                      height: 60,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: const Icon(Icons.phone,
                                  color: Colors.white, size: 28)),
                          Container(
                              width: 98,
                              margin: const EdgeInsets.only(left: 12),
                              child: Text(
                                "전화 예약하기",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17),
                              )),
                        ],
                      )))))
    ]);
  }
}
