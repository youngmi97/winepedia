import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../constants.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget(this.controller, this.posterImage, {Key? key})
      : super(key: key);
  final VideoPlayerController controller;
  final String posterImage;

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [kDefaultShadow],
                  image: DecorationImage(
                      fit: BoxFit.fill, image: AssetImage(posterImage))));

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: VideoPlayer(controller),
      );
}
