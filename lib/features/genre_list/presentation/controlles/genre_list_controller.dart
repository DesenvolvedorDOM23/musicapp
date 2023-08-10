import 'package:get/get.dart';
import 'package:music_app/core/errors/failure.dart';
import 'package:music_app/shared/models/genre_models.dart';
import '../../../../core/mixin/screen_loading_and_error_mixin.dart';
import '../../data/repository/genre_list_repository.dart';

class GenreListController extends GetxController with ScreenLoadingAndError {
  final GenreListRepository _genreListRepository;
  GenreListController(GenreListRepository genreListRepository)
      : _genreListRepository = genreListRepository;
  final RxList<GenreModels> genres = RxList([]);
  @override
  void onInit() {
    getGenreList();
    super.onInit();
  }

  Future<void> getGenreList() async {
    setLoadingTotrue();
    setError(null);

    final getGenresReponse = await _genreListRepository.getGenreList();

    getGenresReponse.fold((Failure failureResponse) {
      if (failureResponse is GetGenreListFailure) {
        setError(failureResponse.message);
      }
    }, (List<GenreModels> genreResponse) {
      genres.value = genreResponse;
    });
    setLoadingToFalse();
  }
}
