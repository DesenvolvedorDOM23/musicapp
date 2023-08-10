import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_details/presentation/widget/genre_detail_music_list_widget.dart';
import 'package:music_app/features/genre_details/presentation/widget/genre_details_appbar_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/mini_music_player.dart';
import 'package:music_app/shared/models/genre_models.dart';

class GenreDetailsScreen extends StatelessWidget {
  const GenreDetailsScreen({super.key});
  static String routName = '/Genre-detail';

  @override
  Widget build(BuildContext context) {
    final musicPlayercontroller = Get.find<MusicPlayerControlles>();
    final genre = Get.arguments as GenreModels;
    return Scaffold(
        backgroundColor: MusicAppColors.primaryColor,
        body: Obx(
          () => Column(
            children: [
              Expanded(
                  child: CustomScrollView(
                slivers: [
                  GenreDetailsAppbarWidget(
                    genre: genre,
                  ),
                  GenreDetailMusicListWidget(
                      genreSearchingString: genre.searchString),
                ],
              )),
              if (musicPlayercontroller.getPlaylistPlaying.isNotEmpty)
                const MiniMusicPlayer(),
            ],
          ),
        ));
  }
}
