import 'package:music_app/shared/models/genre_models.dart';
import 'package:music_app/shared/models/music_models.dart';

class GenreDetailModel extends GenreModels {
  final List<MusicModel> musics;
  GenreDetailModel({
    required super.img,
    required super.title,
    required this.musics,
    required super.searchString,
  });

  factory GenreDetailModel.fromMap(Map<String, dynamic> map) {
    return GenreDetailModel(
      title: map['title'] ?? '',
      musics: (map['musics'] as List)
          .map((musics) => MusicModel.fromMap(musics))
          .toList(),
      searchString: map['searchString'] ?? '',
      img: map['img'],
    );
  }
}
