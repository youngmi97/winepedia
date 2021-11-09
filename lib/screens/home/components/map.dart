import 'dart:async';

import 'package:winepedia/constants.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:winepedia/screens/details/details_screen.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:winepedia/screens/home/components/body.dart';
import 'package:winepedia/models/custom_class.dart';

import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class BaseMapPage extends StatefulWidget {
  const BaseMapPage({Key? key}) : super(key: key);
  @override
  _BaseMapPageState createState() => _BaseMapPageState();
}

class _BaseMapPageState extends State<BaseMapPage> {
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final mapKey = GlobalKey();
  final Completer<NaverMapController> _controller = Completer();

  final MapType _mapType = MapType.Basic;
  final LocationTrackingMode _trackingMode = LocationTrackingMode.NoFollow;
  int initialPage = 0;
  final List<Marker> _markers = [];
  final List<LatLng> _coordinates = const [
    LatLng(37.50310059666677, 127.02686362667359),
    LatLng(37.49224267309452, 127.02954231381753),
    LatLng(37.503448818680404, 127.02667444016569),
    LatLng(37.494844939278025, 127.0281809843455),
    LatLng(37.50235677686214, 127.03556508784166)
  ];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _coordinates.forEach(
        (point) async {
          final OverlayImage markerImage = await OverlayImage.fromAssetImage(
              assetName: "assets/images/bar_marker.png", context: context);
          _markers.add(
            Marker(
                markerId: point.json.toString(),
                position: point,
                icon: markerImage,
                width: 32,
                height: 39,
                iconTintColor: Colors.black26,
                onMarkerTab: _onMarkerTap),
          );
        },
      );
    });
    _moveCameraIndex(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      //appBar: AppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          NaverMap(
            //key: mapKey,
            markers: _markers,
            onMapCreated: _onMapCreated,
            mapType: _mapType,
            initLocationTrackingMode: _trackingMode,
            //locationButtonEnable: true,
            indoorEnable: true,
          ),
          GestureDetector(
              onTap: () {
                _determinePosition().then((value) => {
                      //print(value.latitude),
                      _moveCameraLatLng(LatLng(value.latitude, value.longitude))
                    });
              },
              child: Container(
                  width: 48,
                  height: 48,
                  margin: EdgeInsets.only(
                      bottom: size.height - 114, right: kDefaultPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage(
                                  "assets/images/locationArrow.jpg")))))),
          Padding(
              padding: const EdgeInsets.only(bottom: 53),
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  height: 134,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      initialPage = index;
                    });
                    //print(_markers[initialPage].iconTintColor);
                    _moveCameraIndex(index);
                    for (var i = 0; i < _markers.length; i++) {
                      if (i == initialPage) {
                        // _markers[i].iconTintColor = Colors.black26;
                      } else {
                        // _markers[i].iconTintColor = Colors.black26;
                      }
                    }
                  },
                ),
                items: const [
                  CarouselPage(0),
                  CarouselPage(1),
                  CarouselPage(2),
                  CarouselPage(3),
                  CarouselPage(4),
                ],
              ))
        ],
      ),
    );
  }

  void _onMapCreated(NaverMapController controller) {
    _controller.complete(controller);
    //print("map crteate");
    controller.moveCamera(CameraUpdate.fitBounds(
      LatLngBounds.fromLatLngList(_coordinates),
      padding: 48,
    ));
  }

  ///marker interaction

  void _onMarkerTap(Marker marker, Map<String, int> iconSize) {
    print("${marker.position}");
  }

  void _moveCameraIndex(int index) async {
    final controller = await _controller.future;
    controller.moveCamera(CameraUpdate.scrollTo(_coordinates[index]));
  }

  void _moveCameraLatLng(LatLng position) async {
    final controller = await _controller.future;
    controller.moveCamera(CameraUpdate.scrollTo(position));
  }
}

class CarouselPage extends StatefulWidget {
  final int index;
  const CarouselPage(this.index, {Key? key}) : super(key: key);

  @override
  CarouselPageState createState() => CarouselPageState();
}

class CarouselPageState extends State<CarouselPage> {
  ItemContext? barContent;
  @override
  void initState() {
    fetchData("2021000" + (widget.index + 1).toString()).then((value) => {
          barContent = value,
          //print(barContent?.phoneNumber),
          setState(() {})
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //print(index);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(barContent, wineBar: wineBars[widget.index])),
          );
        },
        child: Container(
            width: size.width - 3 * kDefaultPadding,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )),
            child: Row(children: <Widget>[
              Container(
                  height: 134,
                  width: (size.width - 3 * kDefaultPadding) * 0.22,
                  margin: const EdgeInsets.only(right: kDefaultPadding),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                          image:
                              AssetImage("assets/images/bar_template.jpg")))),
              barContent?.name == null
                  ? const SizedBox(width: 0.1)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 21,
                            width: (size.width - 3 * kDefaultPadding) * 0.78 -
                                kDefaultPadding,
                            child: Text(
                              "${barContent?.name}",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17),
                            )),
                        Container(
                            height: 18,
                            width: (size.width - 3 * kDefaultPadding) * 0.78 -
                                kDefaultPadding,
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              "정상 영업중",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: const Color(0xFF34C759),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                            )),
                        Container(
                            height: 38,
                            width: (size.width - 3 * kDefaultPadding) * 0.78 -
                                kDefaultPadding -
                                50,
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              "${barContent?.sAddr}",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                            )),
                      ],
                    ),
            ])));
  }
}
