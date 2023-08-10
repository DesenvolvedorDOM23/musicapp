import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';

mixin SnackBarrMixin {
  void showErrorSnackBar(String description) {
    Get.snackbar(
      'error',
      description,
      colorText: MusicAppColors.secundaryColor,
      backgroundColor: MusicAppColors.errorColor,
    );
  }
}
