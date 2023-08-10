import 'package:get/get.dart';
import 'package:music_app/core/app/service/apiservices.dart';
import 'package:music_app/features/genre_details/data/repository/genre_detail_repository.dart';
import 'package:music_app/features/genre_details/presentation/controllers/genre_details_controller.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';

class GenreDetailBidings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GenreDetailsController(
        GenreDetailRepository(
          apiServices: Get.find<ApiServices>(),
        ),
        Get.find<MusicPlayerControlles>(),
      ),
    );
  }
}
