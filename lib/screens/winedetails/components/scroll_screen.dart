import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';

class ScrollScreen extends StatelessWidget {
  const ScrollScreen(this.wineName, this.grapeName, this.country, {Key? key})
      : super(key: key);

  final String wineName;
  final String grapeName;
  final String country;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String wineString = wineName.replaceAll(" ", "_");
    String countryString = country + "_wide";
    return Column(children: <Widget>[
      Container(
        height: 326,
        width: 87,
        margin: const EdgeInsets.only(top: 43, bottom: 63),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/$wineString.jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Container(
              width: size.width - kDefaultPadding,
              height: 20,
              margin: const EdgeInsets.only(left: kDefaultPadding, bottom: 8),
              child: Text(
                '$wineName (2019)',
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
              )),
          Row(children: <Widget>[
            Container(
                width: size.width / 2 - kDefaultPadding,
                height: 18,
                margin: const EdgeInsets.only(left: kDefaultPadding),
                child: Text(
                  grapeName,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
                )),
            Container(
                width: size.width / 2 - kDefaultPadding,
                height: 18,
                margin: const EdgeInsets.only(right: kDefaultPadding),
                child: Text(
                  "3-4만원",
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                )),
          ]),
          Row(children: <Widget>[
            Container(
              height: 20.0,
              width: 35.6,
              margin: const EdgeInsets.only(left: kDefaultPadding, top: 13),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/$countryString.jpg'),
                ),
              ),
            ),
            Container(
                height: 16,
                margin: const EdgeInsets.only(left: 9.2, top: 13),
                child: Text(
                  "프랑스산",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                )),
          ]),
        ],
      ),
    ]);
  }
}
