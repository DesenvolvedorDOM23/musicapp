import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/service/apiservices.dart';
import 'package:music_app/core/app/service/audio_services/audioservicesimpl.dart';
import 'package:music_app/core/app/service/dot_env_service.dart';

import '../../shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';

class MusicAppInitialBidings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ApiServices(
        BaseOptions(
          baseUrl: DotEnvService.getApiBaseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ),
    );

    Get.put(
      AudioServiceImpl(
        audioPlayer: AudioPlayer(),
      ),
    );

    Get.lazyPut(() => MusicPlayerControlles(
          AudioServiceImpl(
            audioPlayer: AudioPlayer(),
          ),
        ));
  }
}
