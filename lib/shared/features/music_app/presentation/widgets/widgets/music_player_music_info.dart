import 'package:flutter/material.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/text_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/music_player_duration_widget.dart';
import 'package:music_app/shared/models/music_models.dart';
import 'package:music_app/shared/widgets/image_widget.dart';

class MusicPlayerMusicInfo extends StatelessWidget {
  final MusicModel music;
  const MusicPlayerMusicInfo({
    super.key,
    required this.music,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(builder: (_, contraints) {
          return ImageWidget(
            heigth: contraints.maxHeight,
            width: contraints.maxWidth,
            img: music.img,
          );
        }),
        const SizedBox(
          height: 14,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: TextWidget.title(music.title),
        ),
        const SizedBox(
          height: 24,
        ),
        MusicPlayerDurationWidget(duration: music.duration)
      ],
    );
  }
}
