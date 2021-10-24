import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NaverMap();
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed")));
  }
}
