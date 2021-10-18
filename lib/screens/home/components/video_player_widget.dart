import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../constants.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget(this.controller, this.posterImage, {Key? key})
      : super(key: key);
  final VideoPlayerController controller;
  final String posterImage;

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(alignment: Alignment.topCenter, child: buildVideo())
      : Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [kDefaultShadow],
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage(posterImage))));

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: VideoPlayer(controller),
      );
}
