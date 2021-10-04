import 'package:flutter/material.dart';

class RedWinePage extends StatelessWidget {
  const RedWinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            //Here you can set what ever background color you need.
            backgroundColor: Colors.grey[100],
            body: Column(children: <Widget>[
              Row(
                children: [
                  WineDisplayContainer("로스 바스코스", "카르보네 소비뇽"),
                  WineDisplayContainer("파미유 페랑", "라비에이유 페름루즈"),
                ],
              ),
              Row(children: [
                WineDisplayContainer("마샤렐리", "몬테풀치아노 다부르쪼"),
              ])
            ])));
  }
}

class WineDisplayContainer extends StatelessWidget {
  WineDisplayContainer(this.wineName, this.grapeName, {Key? key})
      : super(key: key);
  final String wineName;
  final String grapeName;
  @override
  Widget build(BuildContext context) {
    String myString = wineName.replaceAll(" ", "_");
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 227,
        width: 180,
        margin: const EdgeInsets.only(left: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(left: 148, top: 14),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/italy.jpg"),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 140,
                    width: 35,
                    margin: const EdgeInsets.only(top: 14),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/$myString.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                      width: size.width,
                      margin: const EdgeInsets.only(left: 14, top: 20),
                      child: Text(
                        wineName,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  Container(
                      width: size.width,
                      margin: const EdgeInsets.only(left: 14, top: 4),
                      child: Text(
                        grapeName,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ))
                ]),
          ],
        ));
  }
}
