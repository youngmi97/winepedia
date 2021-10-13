import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winepedia/screens/winedetails/components/scroll_screen.dart';

class Wine_Taste_Bar extends StatelessWidget {
  const Wine_Taste_Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      Container(
          width: size.width - kDefaultPadding,
          height: 20,
          margin: const EdgeInsets.only(left: kDefaultPadding),
          child: Text(
            "와인 시음",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
          )),
      tasteBar("당도", 0.68, 0.12),
      tasteBar("산도", 0.54, 0.32),
      tasteBar("바디", 0.14, 0.22),
      tasteBar("타닌", 0.23, 0.72),
    ]);
  }
}

class tasteBar extends StatelessWidget {
  tasteBar(this.tasteType, this.ownerPick, this.average, {Key? key})
      : super(key: key);
  dynamic tasteType;
  dynamic ownerPick;
  dynamic average;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bar_length = size.width - 2 * kDefaultPadding;

    return Column(children: <Widget>[
      Container(
          width: size.width - kDefaultPadding,
          height: 18,
          margin: const EdgeInsets.only(left: kDefaultPadding, top: 24),
          child: Text(
            "$tasteType",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
          )),
      Stack(children: <Widget>[
        Container(
          width: bar_length,
          margin: const EdgeInsets.only(top: 12),
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
            width: 32,
            margin: EdgeInsets.only(top: 12, left: bar_length * ownerPick),
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF4C032B),
              borderRadius: BorderRadius.circular(4),
            )),
        Container(
          width: 32,
          margin: EdgeInsets.only(top: 12, left: bar_length * average),
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0x4D4C032B),
            borderRadius: BorderRadius.circular(4),
          ),
        )
      ])
    ]);
  }
}
