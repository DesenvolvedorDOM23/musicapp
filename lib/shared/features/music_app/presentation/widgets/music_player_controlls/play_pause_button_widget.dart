import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';

enum PlayPauseButtonSize { small, normal }

class PlayPauseButtonWidget extends StatelessWidget {
  final String? musicUrl;
  final PlayPauseButtonSize _playPauseButtonSize;
  const PlayPauseButtonWidget({
    this.musicUrl,
    PlayPauseButtonSize? playPauseButtonSize,
    super.key,
  }) : _playPauseButtonSize = playPauseButtonSize ?? PlayPauseButtonSize.normal;

  @override
  Widget build(BuildContext context) {
    final musicPlaycontroller = Get.find<MusicPlayerControlles>();
    return Obx(() => IconButton(
          onPressed: () async {
            if (musicUrl != null) {
              if (musicPlaycontroller.isPlaying.value) {
                musicPlaycontroller.playMusic(musicUrl!);
              } else {
                musicPlaycontroller.playMusic(musicUrl!);
              }
            }
          },
          icon: Icon(
            musicPlaycontroller.isPlaying.value
                ? Icons.pause_circle
                : Icons.play_circle,
            color: MusicAppColors.secundaryColor,
          ),
          padding: const EdgeInsets.all(0),
          iconSize:
              _playPauseButtonSize == PlayPauseButtonSize.normal ? 70 : 50,
        ));
  }
}
