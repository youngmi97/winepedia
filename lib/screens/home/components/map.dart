import 'dart:async';

import 'package:winepedia/constants.dart';
import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:winepedia/screens/details/details_screen.dart';
import 'package:winepedia/models/winebar.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

// Future<String> fetchAlbum() async {
//   final response = await http.get(Uri.parse(
//       'https://79jx2bj9ed.execute-api.ap-northeast-2.amazonaws.com/dev/search-wine?name=Riesling'));
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     print(response.body);
//     return response.body;
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

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
    LatLng(37.563153, 126.962190),
    LatLng(37.533153, 126.922190),
    LatLng(37.583153, 126.982190),
  ];

  LatLng initialPos = const LatLng(37.563153, 126.962190);
  @override
  void initState() {
    //OverlayImage image = await OverlayImage.fromAssetImage(assetName: "assets/images/pin_default.png", context: context);
    _coordinates.forEach(
      (point) {
        _markers.add(
          Marker(
              markerId: point.json.toString(),
              position: point,
              width: 27,
              height: 33,
              iconTintColor: Colors.brown[900],
              onMarkerTab: _onMarkerTap),
        );
      },
    );
    super.initState();
    // _coordinates.forEach((point) {
    //   WidgetsBinding.instance!.addPostFrameCallback((post) {
    //     OverlayImage.fromAssetImage(
    //             assetName: 'icon/marker.png', context: context)
    //         .then((image) {
    //       print(image);
    //       _markers.add(Marker(
    //           markerId: point.json.toString(),
    //           position: point,
    //           captionText: "커스텀 아이콘",
    //           captionColor: Colors.indigo,
    //           captionTextSize: 20.0,
    //           alpha: 0.8,
    //           captionOffset: 30,
    //           icon: image,
    //           anchor: AnchorPoint(0.5, 1),
    //           width: 45,
    //           height: 45,
    //           infoWindow: '인포 윈도우',
    //           onMarkerTab: _onMarkerTap));
    //     });
    //   });
    // });
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
            onMapTap: _onMapTap,
            onMapLongTap: _onMapLongTap,
            onMapDoubleTap: _onMapDoubleTap,
            onMapTwoFingerTap: _onMapTwoFingerTap,
            onSymbolTap: _onSymbolTap,
          ),
          GestureDetector(
              behavior: HitTestBehavior.translucent,
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
                        _markers[i].iconTintColor = const Color(0xFFCC0000);
                      } else {
                        _markers[i].iconTintColor = Colors.green;
                      }
                    }
                  },
                ),
                items: const [
                  CarouselPage(0),
                  CarouselPage(1),
                  CarouselPage(2),
                ],
              ))
        ],
      ),
    );
  }

  void _onMapCreated(NaverMapController controller) {
    _controller.complete(controller);
    //print("map crteate");
    controller.moveCamera(CameraUpdate.scrollTo(initialPos));
  }

  _onMapTap(LatLng position) async {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content:
          Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapLongTap(LatLng position) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(
          '[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapDoubleTap(LatLng position) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(
          '[onDoubleTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapTwoFingerTap(LatLng position) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(
          '[onTwoFingerTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onSymbolTap(LatLng position, String caption) {
    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(
          '[onSymbolTap] caption: $caption, lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
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

  //scroll screen components

  /// 지도 유형 선택시
  // void _onTapTypeSelector(MapType type) async {
  //   if (_mapType != type) {
  //     setState(() {
  //       _mapType = type;
  //     });
  //   }
  // }

  /// my location button
  // void _onTapLocation() async {
  //   final controller = await _controller.future;
  //   controller.setLocationTrackingMode(LocationTrackingMode.Follow);
  // }

  // void _onCameraChange(
  //     LatLng latLng, CameraChangeReason reason, bool isAnimated) {
  //   print('카메라 움직임 >>> 위치 : ${latLng.latitude}, ${latLng.longitude}'
  //       '\n원인: $reason'
  //       '\n에니메이션 여부: $isAnimated');
  // }

  // void _onCameraIdle() {
  //   print('카메라 움직임 멈춤');
  // }

  /// 지도 스냅샷
  // void _onTapTakeSnapShot() async {
  //   final controller = await _controller.future;
  //   controller.takeSnapshot((path) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             contentPadding: EdgeInsets.zero,
  //             content: path != null
  //                 ? Image.file(
  //                     File(path),
  //                   )
  //                 : Text('path is null!'),
  //             titlePadding: EdgeInsets.zero,
  //           );
  //         });
  //   });
  // }

}

class CarouselPage extends StatelessWidget {
  const CarouselPage(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //print(index);

    return GestureDetector(
        onTap: () {
          print(index - 1);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(wineBar: wineBars[index])),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 21,
                      width: (size.width - 3 * kDefaultPadding) * 0.78 -
                          kDefaultPadding,
                      child: Text(
                        "가르고뜨",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      )),
                  Container(
                      height: 18,
                      width: (size.width - 3 * kDefaultPadding) * 0.78 -
                          kDefaultPadding,
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "정상 영업중",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: const Color(0xFF34C759),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      )),
                  Container(
                      height: 38,
                      width: (size.width - 3 * kDefaultPadding) * 0.78 -
                          kDefaultPadding,
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "서울특별시 서초구 아크로텔\n효령료77길 34 116호",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      )),
                ],
              ),
            ])));
  }
}
