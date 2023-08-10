import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/music_player_controlls/play_pause_button_widget.dart';

class MusicPlayerControlsWidget extends StatelessWidget {
  final String musicPath;
  const MusicPlayerControlsWidget({
    super.key,
    required this.musicPath,
  });

  @override
  Widget build(BuildContext context) {
    final musicplayercontroller = Get.find<MusicPlayerControlles>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => musicplayercontroller.backTrack(),
          icon: Icon(
            Icons.skip_previous,
            color: MusicAppColors.secundaryColor,
          ),
          iconSize: 70,
        ),
        const SizedBox(
          width: 40,
        ),
        PlayPauseButtonWidget(
          musicUrl: musicPath,
        ),
        const SizedBox(
          width: 40,
        ),
        IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => musicplayercontroller.skipTrack(),
          icon: Icon(
            Icons.skip_next,
            color: MusicAppColors.secundaryColor,
          ),
          iconSize: 70,
        ),
      ],
    );
  }
}
