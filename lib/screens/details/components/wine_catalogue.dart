import 'package:flutter/material.dart';
import 'package:winepedia/screens/winedetails/taste_bar.dart';

class WineCatalogue extends StatelessWidget {
  const WineCatalogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            //Here you can set what ever background color you need.
            backgroundColor: Colors.grey[100],
            body: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TasteBar(
                                  "로스 바스코스", "카르보네 소비뇽", "italy")),
                        );
                      },
                      child: const WineDisplayContainer(
                          "로스 바스코스", "카르보네 소비뇽", "italy")),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TasteBar(
                                "파미유 페랑", "라비에이유 페름루즈", "france")),
                      );
                    },
                    child: const WineDisplayContainer(
                        "파미유 페랑", "라비에이유 페름루즈", "france"),
                  )
                ],
              ),
              const WineDisplayContainer("마샤렐리", "몬테풀치아노 다부르쪼", "italy"),
            ])));
  }
}

class WineDisplayContainer extends StatelessWidget {
  const WineDisplayContainer(this.wineName, this.grapeName, this.country,
      {Key? key})
      : super(key: key);
  final String wineName;
  final String grapeName;
  final String country;
  @override
  Widget build(BuildContext context) {
    String wineString = wineName.replaceAll(" ", "_");
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 227,
        width: size.width * 0.43,
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
              margin: EdgeInsets.only(left: (size.width * 0.43 - 30), top: 14),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/$country.jpg"),
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
                        image: AssetImage('assets/images/$wineString.jpg'),
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
