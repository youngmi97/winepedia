import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:winepedia/constants.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/home/components/carousel_card.dart';
import '../../../constants.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

ItemContext parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody);

  APIbody winebarList = APIbody.fromJson(parsed);
  //print(winebarList.body);
  Items itemList = Items.fromJson(winebarList.body);
  //print(itemList.items[0]);
  ItemContext itemContent = ItemContext.fromJson(itemList.items[0]);
  //print(ItemContent.name);
  return itemContent;
}

class APIbody {
  Map<String, dynamic> body;

  APIbody({required this.body});

  factory APIbody.fromJson(Map<String, dynamic> parsedJson) {
    return APIbody(
      body: parsedJson['body'],
    );
  }
}

class Items {
  List<dynamic> items;

  Items({required this.items});

  factory Items.fromJson(Map<String, dynamic> parsedJson) {
    return Items(
      items: parsedJson['Items'],
    );
  }
}

class ItemContext {
  String name;
  String phoneNumber;
  String address;
  ItemContext(
      {required this.name, required this.phoneNumber, required this.address});

  factory ItemContext.fromJson(Map<String, dynamic> parsedJson) {
    return ItemContext(
      name: parsedJson['NAME'],
      phoneNumber: parsedJson['PHONE'],
      address: parsedJson['ADDRESS'],
    );
  }
}

Future<ItemContext> fetchData(String Id) async {
  final response = await http.get(Uri.parse(
      'https://uidlxhemcj.execute-api.ap-northeast-2.amazonaws.com/dev/search-bar?id=$Id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    // print('데이터 수신' + response.contentLength.toString() + "byte");
    // print(response.body);
    // print(parsePhotos((response.body)).name);
    // print(parsePhotos((response.body)).phoneNumber);
    // print(parsePhotos((response.body)).address);
    return parsePhotos(response.body);
  } else {
    //print(response.body);
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Body extends StatefulWidget {
  Function hideBottomNavigation;
  Function showBottomNavigation;
  Body(this.showBottomNavigation, this.hideBottomNavigation, {Key? key})
      : super(key: key);
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  late ItemContext barContent;
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        //print(scrollInfo.metrics.maxScrollExtent);
        if (scrollInfo.metrics.pixels <= 0) {
          widget.showBottomNavigation();
          return true;
        } else if (scrollInfo.metrics.maxScrollExtent <= 269.3) {
          widget.hideBottomNavigation();
          return false;
        } else {
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
              child: SizedBox(
                height: size.height * 1.2,
                child: Scaffold(
                    body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AddressBar(),
                    Heading(),
                    Carousel(),
                    GestureDetector(
                      onTap: () {
                        _launchURL();
                      },
                      child: AddNewWineBar(),
                    )
                    //AddNewWineBar(),
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
        height: size.height * 0.15,
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
            CarouselPage(initialPage, 4),
          ],
        ));
  }
}

class AddNewWineBar extends StatelessWidget {
  const AddNewWineBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width - 2 * kDefaultPadding,
        height: size.height * 0.11,
        margin: const EdgeInsets.only(top: 40, left: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: const Color(0xFFE8E9EB),
            width: 1,
          ),
          color: const Color(0xFFFFFFFF),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              spreadRadius: 2,
              blurRadius: 16,
            ),
          ],
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(left: kDefaultPadding),
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(12),
                  //   bottomLeft: Radius.circular(12),
                  // ),
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft,
                      image: AssetImage("assets/images/WineportLogo.jpg")))),
          Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 24,
                    width: 223,
                    margin: const EdgeInsets.only(top: 8),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: const TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '내가 즐겨찾는 '),
                          TextSpan(
                              text: '와인바',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '가 없나요?'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 24,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 24,
                                width: 223,
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                        color: const Color(0xFF4C032B),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                    children: [
                                      TextSpan(
                                        text: "나만 알고있는 와인바 추천하기 ",
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.top,
                                        child: Icon(SFSymbols.chevron_right,
                                            color: Color(0xFF4C032B), size: 15),
                                      ),
                                    ],
                                  ),
                                )),
                          ])),
                ],
              )),
        ]));
  }
}

class CarouselPage extends StatefulWidget {
  const CarouselPage(this.initialPage, this.index, {Key? key})
      : super(key: key);
  final int initialPage;
  final int index;

  @override
  CarouselPageState createState() => CarouselPageState();
}

class CarouselPageState extends State<CarouselPage> {
  ItemContext? barContent;
  @override
  void initState() {
    fetchData("2021000" + (widget.index + 1).toString()).then((value) => {
          barContent = value,
          //print(barContent?.address),
          setState(() {})
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: widget.initialPage == widget.index ? 1 : 0.4,
      // child: Transform.scale(
      //   scale: initialPage == index ? 1 : 1,
      child: CarouselCard(widget.initialPage, widget.index, barContent?.name,
          barContent?.phoneNumber, barContent?.address, wineBars[widget.index]),
      //),
    );
  }
}

_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
