import 'package:get/get.dart';
import 'package:music_app/core/app/service/apiservices.dart';
import 'package:music_app/features/genre_list/data/repository/genre_list_repository.dart';
import 'package:music_app/features/genre_list/presentation/controlles/genre_list_controller.dart';

class GenrelistBidings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      GenreListController(
        GenreListRepository(
          apiServices: Get.find<ApiServices>(),
        ),
      ),
    );
  }
}
