import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerLocalAsset extends StatefulWidget {
  @override
  _AudioPlayerLocalAssetState createState() => _AudioPlayerLocalAssetState();
}

class _AudioPlayerLocalAssetState extends State<AudioPlayerLocalAsset> {
  /// For clarity, I added the terms compulsory and optional to certain sections
  /// to maintain clarity as to what is really needed for a functioning audio player
  /// and what is added for further interaction.
  ///
  /// 'Compulsory': A functioning audio player with:
  ///             - Play/Pause button
  ///
  /// 'Optional': A functioning audio player with:
  ///             - Play/Pause button
  ///             - time stamps for progress and duration
  ///             - slider to jump within the audio file
  ///
  /// Compulsory
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.PAUSED;
  AudioCache audioCache = AudioCache();
  String filePath = 'sound/bottle.wav';

  @override
  void initState() {
    super.initState();

    /// Compulsory
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        audioPlayerState = s;
      });
    });
  }

  /// Compulsory
  /// Compulsory
  playMusic() async {
    await audioCache.play(filePath);
  }

  /// Compulsory
  pauseMusic() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        /// Compulsory
        IconButton(
            iconSize: 50,
            onPressed: () {
              audioPlayerState == PlayerState.PLAYING
                  ? pauseMusic()
                  : playMusic();
              setState(() {});
            },
            icon: Icon(audioPlayerState == PlayerState.PLAYING
                ? Icons.pause_rounded
                : Icons.play_arrow_rounded)),
      ],
    ));
  }
}
