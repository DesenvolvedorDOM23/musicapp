import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_details/presentation/controllers/genre_details_controller.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/app_music_error_widget.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/text_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';
import 'package:music_app/shared/models/music_models.dart';
import 'package:music_app/shared/widgets/ImgAndTitleRowWidget.dart';

import '../../../../shared/widgets/circular_progress_indicator_widget.dart';

class GenreDetailMusicListWidget extends StatelessWidget {
  final String genreSearchingString;
  const GenreDetailMusicListWidget({required this.genreSearchingString});
  Color _getMusicTitleColor(
      MusicModel currentMusicInList, MusicModel? currentMusicPlaying) {
    if (currentMusicInList.title == currentMusicPlaying?.title) {
      return MusicAppColors.tertiaryColor;
    } else {
      return MusicAppColors.secundaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final genreDetailcontroller = Get.find<GenreDetailsController>();
    final musicPlayercontroller = Get.find<MusicPlayerControlles>();

    return Obx(
      () => SliverList(
        delegate: SliverChildListDelegate(
          [
            const SizedBox(
              height: 8,
            ),
            if (genreDetailcontroller.getIsloading)
              const CircularProgressIndicatorWidget(),
            if (!genreDetailcontroller.getIsloading &&
                genreDetailcontroller.getError != null)
              AppMusicErrorWidget(
                error: genreDetailcontroller.getError!,
                onTryAgain: () => genreDetailcontroller
                    .loadGenreDetails(genreSearchingString),
              ),
            if (!genreDetailcontroller.getIsloading &&
                genreDetailcontroller.getError == null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget.title('Musicas'),
                    const SizedBox(
                      height: 12,
                    ),
                    ...genreDetailcontroller.genredetails?.musics
                            .asMap()
                            .map(
                              (int index, MusicModel music) =>
                                  MapEntry(index, Builder(
                                builder: (BuildContext) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () => musicPlayercontroller
                                            .playerSelectedMusic(
                                                context, index),
                                        child: ImgAndTitleRowWidget(
                                          title: music.title,
                                          heroTag: index.toString(),
                                          img: music.img,
                                          titleColor: _getMusicTitleColor(
                                            music,
                                            musicPlayercontroller
                                                .getCurrentPlayingMusic,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  );
                                },
                              )),
                            )
                            .values
                            .toList() ??
                        [],
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
