import 'package:flutter/material.dart';
import 'package:winepedia/screens/home/components/body.dart';
import 'package:winepedia/screens/home/components/map.dart';
import 'package:winepedia/constants.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeTab() {
    setState(() {
      _selectedIndex = _selectedIndex == 0 ? 1 : 0;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const Body(),
    const BaseMapPage(),
  ];

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        Visibility(
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _changeTab();
              },
              child: Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(top: 64, left: kDefaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 36,
                  ))),
          visible: _selectedIndex == 0 ? false : true,
        )
      ]),
      bottomNavigationBar: Stack(children: [
        Visibility(
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.red,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Business',
                backgroundColor: Colors.green,
              ),
            ],
            iconSize: 25,
            currentIndex: _selectedIndex,
            backgroundColor: const Color(0xFFFFFFFF),
            selectedItemColor: Colors.black,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
          visible: _selectedIndex == 0 ? true : false,
        ),
      ]),
    );
  }
}
