import 'package:flutter/material.dart';
import 'package:music_app/core/extensions/media_query_extensions.dart';
import 'package:music_app/shared/models/genre_models.dart';
import 'package:music_app/shared/widgets/image_widget.dart';

class GenreDetailsAppbarWidget extends StatelessWidget {
  final GenreModels genre;
  const GenreDetailsAppbarWidget({required this.genre});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.getWidth / 1.5,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: context.getWidth / 3 - 12),
        stretchModes: [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
        background: Hero(
          tag: genre.title,
          child: ImageWidget(
            heigth: context.getHeight,
            img: genre.img,
            width: context.getWidth / 1.5,
          ),
        ),
      ),
    );
  }
}
