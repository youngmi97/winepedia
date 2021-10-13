import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/screens/winedetails/components/body.dart';

class TasteBar extends StatelessWidget {
  const TasteBar(this.wineName, this.grapeName, this.country, {Key? key})
      : super(key: key);
  final String wineName;
  final String grapeName;
  final String country;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white, toolbarHeight: 0, elevation: 0),
        body: Column(children: <Widget>[
          Row(children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 14),
                width: 14,
                height: 36,
                child: const BackButton(
                  color: Colors.black,
                )),
            Container(
                margin: EdgeInsets.only(left: 14, top: 6.5),
                child: Text(
                  "가르고뜨",
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 17),
                ))
          ]),
          Body(wineName, grapeName, country),
        ]));
  }
}
