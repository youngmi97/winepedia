import 'package:flutter/material.dart';
import 'package:winepedia/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:winepedia/screens/winedetails/components/scroll_screen.dart';
import 'package:winepedia/screens/winedetails/components/wine_taste_bar.dart';
import 'package:winepedia/screens/winedetails/components/food_pairing.dart';

class Body extends StatelessWidget {
  const Body(this.wineName, this.grapeName, this.country, {Key? key})
      : super(key: key);

  final String wineName;
  final String grapeName;
  final String country;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DraggableScrollableSheet(
            minChildSize: 0.99999999999,
            maxChildSize: 1,
            initialChildSize: 1,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
                child: SizedBox(
                  height: 1228,
                  child: Stack(children: <Widget>[
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24)))),
                    Column(children: <Widget>[
                      Scroll_Screen(wineName, grapeName, country),
                      const Divider(
                        height: 48,
                        thickness: 1,
                        indent: kDefaultPadding,
                        endIndent: kDefaultPadding,
                      ),
                      const Wine_Taste_Bar(),
                      const Divider(
                        height: 48,
                        thickness: 1,
                        indent: kDefaultPadding,
                        endIndent: kDefaultPadding,
                      ),
                      const FoodPairing(),
                    ])
                  ]),
                ),
              );
            }));
  }
}
