import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/home/components/carousel_card.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  Function hideBottomNavigation;
  Function showBottomNavigation;
  Body(this.showBottomNavigation, this.hideBottomNavigation, {Key? key})
      : super(key: key);
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        print(scrollInfo.metrics.pixels);
        if (scrollInfo.metrics.pixels <= 0) {
          widget.showBottomNavigation();
          return true;
        } else {
          widget.hideBottomNavigation();
          return false;
        }
      },
      child: DraggableScrollableSheet(
          minChildSize: 1,
          maxChildSize: 1,
          initialChildSize: 1,
          builder: (context, controller) {
            return SingleChildScrollView(
              //reverse: true,
              controller: controller,
              //physics: ClampingScrollPhysics(),
              child: Container(
                height: size.height * 1.2,
                child: Scaffold(
                    body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    AddressBar(),
                    Heading(),
                    Carousel(),
                  ],
                )),
              ),
            );
          }),
    );
  }
}

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: 111,
        color: const Color.fromRGBO(76, 3, 43, 1),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 14),
        child: Text(
          "현재 강남역 도보 10분 거리에 위치한 \n와인바만 보여드리고 있습니다.",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17),
        ));
  }
}

class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 24, left: kDefaultPadding),
        child: Text(
          "강남역 도보 10분 거리에 \n위치해 있는 와인바를 발견해보세요",
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 24),
        ));
  }
}

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  //late PageController _pageController;
  int initialPage = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: CarouselSlider(
          options: CarouselOptions(
            height: size.height * 0.6,
            initialPage: 1,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                initialPage = index;
              });
            },
          ),
          items: [
            CarouselPage(initialPage, 0),
            CarouselPage(initialPage, 1),
            CarouselPage(initialPage, 2),
            CarouselPage(initialPage, 3),
          ],
        ));

    // @override
    // void initState() {
    //   //so that we can small portion shown on left and right side
    //   super.initState();
    //   _pageController =
    //       PageController(viewportFraction: 0.75, initialPage: initialPage);
    // }

    // @override
    // void dispose() {
    //   super.dispose();
    //   _pageController.dispose();
    // }
    // Padding(
    //     padding: const EdgeInsets.symmetric(
    //       vertical: kDefaultPadding,
    //     ),
    //     child: AspectRatio(
    //         aspectRatio: 0.75,
    //         child: PageView.builder(
    //             onPageChanged: (index) {
    //               setState(() {
    //                 initialPage = index;
    //               });
    //             },
    //             controller: _pageController,
    //             itemCount: wineBars.length,
    //             physics: const ClampingScrollPhysics(),
    //             itemBuilder: (context, index) => buildSlider(index))));
  }

//   Widget buildSlider(int index) => (
//           animation: _pageController,
//          builder: (context, child) {
//         double value = 1;
//         if (_pageController.position.haveDimensions) {
//           value = index - _pageController.page!;
//           value = (value * 0.038).clamp(-1, 1);
//         }
//         return AnimatedOpacity(
//           duration: const Duration(milliseconds: 350),
//           opacity: initialPage == index ? 1 : 0.4,
//           child: Transform.scale(
//             scale: initialPage == index ? 1 : 1,
//             child: CarouselCard(wineBar: wineBars[index]),
//           ),
//         );
//       });
// }
}

class CarouselPage extends StatelessWidget {
  const CarouselPage(this.initialPage, this.index, {Key? key})
      : super(key: key);
  final int initialPage;
  final int index;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: initialPage == index ? 1 : 0.4,
      // child: Transform.scale(
      //   scale: initialPage == index ? 1 : 1,
      child: CarouselCard(wineBar: wineBars[index]),
      //),
    );
  }
}
