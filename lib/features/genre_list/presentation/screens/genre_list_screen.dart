import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app/features/genre_list/presentation/controlles/genre_list_controller.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/screen_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/mini_music_player.dart';

import '../../../../shared/widgets/ImgAndTitleRowWidget.dart';

class GenreListScreen extends StatelessWidget {
  const GenreListScreen({super.key});
  static String routName = '/genrelist';
  @override
  Widget build(BuildContext context) {
    final musicPlayerCtrl = Get.find<MusicPlayerControlles>();
    final genreListCtrl = Get.find<GenreListController>();
    print(genreListCtrl.genres.length);

    return Obx(
      () => ScreenWidget(
        error: genreListCtrl.getError,
        onTryAgain: () => genreListCtrl.getGenreList(),
        isloading: genreListCtrl.getIsloading,
        title: 'Lista de Generos',
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  itemBuilder: (_, int index) {
                    final genre = genreListCtrl.genres[index];

                    return InkWell(
                      onTap: () => Get.toNamed(
                        '${GenreListScreen.routName}'
                        '${GenreDetailsScreen.routName}',
                        arguments: genre,
                      ),
                      child: ImgAndTitleRowWidget(
                        title: genre.title,
                        heroTag: genre.title,
                        img: genre.img,
                      ),
                    );
                  },
                  separatorBuilder: (_, ctx) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: genreListCtrl.genres.length,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // if (musicPlayerCtrl.getPlaylistPlaying.isNotEmpty)
            const MiniMusicPlayer()
          ],
        ),
      ),
    );
  }
}
