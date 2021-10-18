import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';

class FoodPairing extends StatelessWidget {
  const FoodPairing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      Container(
          width: size.width - kDefaultPadding,
          height: 20,
          margin: const EdgeInsets.only(left: kDefaultPadding),
          child: Text(
            "이런 음식이랑 어올려요",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
          )),
      Row(children: const <Widget>[
        FoodDisplayContainer("소시지 아스파라거스 볶음"),
        FoodDisplayContainer("사천식 닭가슴살"),
      ])
    ]);
  }
}

class FoodDisplayContainer extends StatelessWidget {
  const FoodDisplayContainer(this.foodName, {Key? key}) : super(key: key);
  final String foodName;
  @override
  Widget build(BuildContext context) {
    String foodString = foodName.replaceAll(" ", "_");
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 227,
        width: size.width * 0.43,
        margin: const EdgeInsets.only(left: 20, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFF2F2F7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                Widget>[
              Container(
                height: 136,
                width: 181,
                margin: const EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/$foodString.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                  width: size.width - 28,
                  margin: const EdgeInsets.only(left: 14, top: 20, right: 14),
                  child: Text(
                    foodName,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
                  )),
            ]),
          ],
        ));
  }
}
