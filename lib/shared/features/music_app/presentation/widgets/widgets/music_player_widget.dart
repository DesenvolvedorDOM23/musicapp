import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/music_player_controls_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/music_player_duration_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/music_player_music_info.dart';
import 'package:music_app/shared/models/music_models.dart';

class MusicPlayerWidget extends StatelessWidget {
  final MusicModel music;
  const MusicPlayerWidget({
    super.key,
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 25,
        sigmaY: 25,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: Get.back,
                  icon: Icon(
                    Icons.arrow_downward_outlined,
                    color: MusicAppColors.secundaryColor,
                  ),
                ),
                MusicPlayerMusicInfo(music: music),
                const SizedBox(
                  height: 24,
                ),
                MusicPlayerDurationWidget(duration: music.duration),
                MusicPlayerControlsWidget(musicPath: music.url),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
