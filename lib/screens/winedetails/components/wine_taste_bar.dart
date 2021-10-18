import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';

class WineTasteBar extends StatelessWidget {
  const WineTasteBar({Key? key}) : super(key: key);

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
      const TasteBar("당도", 0.68, 0.12),
      const TasteBar("산도", 0.54, 0.32),
      const TasteBar("바디", 0.14, 0.22),
      const TasteBar("타닌", 0.23, 0.72),
    ]);
  }
}

class TasteBar extends StatelessWidget {
  const TasteBar(this.tasteType, this.ownerPick, this.average, {Key? key})
      : super(key: key);
  final String tasteType;
  final double ownerPick;
  final double average;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final barLength = size.width - 2 * kDefaultPadding;

    return Column(children: <Widget>[
      Container(
          width: size.width - kDefaultPadding,
          height: 18,
          margin: const EdgeInsets.only(left: kDefaultPadding, top: 24),
          child: Text(
            tasteType,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
          )),
      Stack(children: <Widget>[
        Container(
          width: barLength,
          margin: const EdgeInsets.only(top: 12),
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
            width: 32,
            margin: EdgeInsets.only(top: 12, left: barLength * ownerPick),
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF4C032B),
              borderRadius: BorderRadius.circular(4),
            )),
        Container(
          width: 32,
          margin: EdgeInsets.only(top: 12, left: barLength * average),
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
