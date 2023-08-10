import 'package:get/get.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/core/mixin/screen_loading_and_error_mixin.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';
import 'package:music_app/shared/models/genre_detail_model.dart';
import 'package:music_app/shared/models/genre_models.dart';
import 'package:music_app/shared/models/music_models.dart';

import '../../data/repository/genre_detail_repository.dart';

class GenreDetailsController extends GetxController with ScreenLoadingAndError {
  final GenreDetailRepository _genreDetailRepository;
  final MusicPlayerControlles _musicPlayerControlles;

  GenreDetailsController(
    GenreDetailRepository genreDetailRepository,
    MusicPlayerControlles musicPlayerControlles,
  )   : _genreDetailRepository = genreDetailRepository,
        _musicPlayerControlles = musicPlayerControlles;

  GenreDetailModel? genredetails;

  @override
  void onInit() {
    final genre = Get.arguments as GenreModels;
    loadGenreDetails(genre.searchString);
    super.onInit();
  }

  Future<void> loadGenreDetails(String genre) async {
    setLoadingTotrue();
    setError(null);

    final genreDetailResponseEither =
        await _genreDetailRepository.getGenreDetail(genre);
    genreDetailResponseEither.fold((Failure failureResponse) {
      if (failureResponse is GetGenreDetailFailure) {
        setError(failureResponse.message);
      }
    }, (GenreDetailModel genreDetailsResponse) {
      genredetails = genreDetailsResponse;
      //carrega a selected playlist do music player controller
      _musicPlayerControlles.loadPlaylist(
          genreDetailsResponse.musics, _musicPlayerControlles.selectedPlaylist);
    });
    setLoadingToFalse();
  }

  MusicModel? getMusicByIndex(int index) => genredetails?.musics[index];

  List<MusicModel> get getMusic => genredetails!.musics;
}
