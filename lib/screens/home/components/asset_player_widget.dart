import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:winepedia/screens/home/components/video_player_widget.dart';

class AssetPlayerWidget extends StatefulWidget {
  final String posterVideo;
  const AssetPlayerWidget(this.posterVideo, {Key? key}) : super(key: key);
  @override
  _AssetPlayerWidgetState createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  late VideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.posterVideo)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(controller);
  }
}
