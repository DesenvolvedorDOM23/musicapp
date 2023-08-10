import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/text_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';
import 'package:music_app/shared/widgets/image_widget.dart';

import '../music_player_controlls/play_pause_button_widget.dart';

class MiniMusicPlayer extends StatelessWidget {
  const MiniMusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerController = Get.find<MusicPlayerControlles>();
    return GestureDetector(
      onTap: () => musicPlayerController.showMusicPlayer(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MusicAppColors.primaryColor,
              MusicAppColors.tertiaryColor.withOpacity(0.5),
            ],
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () => Row(
                      children: [
                        ImageWidget(
                          heigth: 50,
                          img:
                              musicPlayerController.getCurrentPlayingMusic?.img,
                          width: 50,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextWidget.normal(
                            musicPlayerController
                                    .getCurrentPlayingMusic?.title ??
                                'musica1',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                PlayPauseButtonWidget(
                  musicUrl: musicPlayerController.getCurrentPlayingMusic?.url,
                  playPauseButtonSize: PlayPauseButtonSize.small,
                ),
                StreamBuilder(
                    stream: musicPlayerController.getCurrentPositionStream,
                    builder: (_, AsyncSnapshot<Duration> snapshot) {
                      final currentPositionInSeconds =
                          snapshot.data?.inSeconds ??
                              musicPlayerController.currentMusicDuration.value;
                      return LinearProgressIndicator(
                        value: (currentPositionInSeconds /
                            (musicPlayerController
                                        .getCurrentPlayingMusic?.duration ??
                                    0)
                                .clamp(0, 1)),
                        backgroundColor: Colors.grey.shade600,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          MusicAppColors.secundaryColor,
                        ),
                      );
                    }),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
