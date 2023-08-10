import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/service/audio_services/audioservices.dart';

import '../../../errors/exceptions.dart';

class AudioServiceImpl extends GetxService implements AudioServices {
  final AudioPlayer audioPlayer;

  AudioServiceImpl({required this.audioPlayer});

  Future<void> callAudioPlayerServiceTryAndCatchFunction(
    Future<void> Function() tryFunction,
    String audiPlayerExceptionMessage,
  ) async {
    try {
      await tryFunction();
    } catch (error, stackTrace) {
      final errormessage = audiPlayerExceptionMessage;

      log(
        errormessage,
        error: error,
        stackTrace: stackTrace,
      );
      throw AudioplayerException(message: errormessage);
    }
  }

  @override
  Future<int> get getCurrentPosition async {
    try {
      final position = await audioPlayer.getCurrentPosition();
      return position?.inSeconds ?? 0;
    } catch (error, stackTrace) {
      const errormessage = 'erro ao pegar posição da musica';
      log(
        errormessage,
        error: error,
        stackTrace: stackTrace,
      );
      throw AudioplayerException(message: errormessage);
    }
  }

  @override
  Stream<Duration> getPositionStream() {
    return audioPlayer.onDurationChanged;
  }

  @override
  Stream<void> onAudioComplete() {
    return audioPlayer.onPlayerComplete;
  }

  @override
  Future<void> pauseMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.pause(),
      "erro ao pausar musica",
    );
  }

  @override
  Future<void> playMusic(String auidoAsset) async {
    return callAudioPlayerServiceTryAndCatchFunction(
      () => audioPlayer.play(AssetSource(auidoAsset)),
      'erro ao carregar musica',
    );
  }

  @override
  Future<void> resumeMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
        () => audioPlayer.resume(), 'erro ao continuar musica');
  }

  @override
  Future<void> seek(int seconds) {
    return callAudioPlayerServiceTryAndCatchFunction(() {
      final seekTo = Duration(seconds: seconds);
      return audioPlayer.seek(seekTo);
    }, 'Erro ao trocar duração da musica ');
  }

  @override
  Future<void> stopMusic() {
    return callAudioPlayerServiceTryAndCatchFunction(
        () => audioPlayer.stop(), 'erro ao parar a musica');
  }

  @override
  void onClose() {
    audioPlayer
      ..stop()
      ..dispose();
    super.onClose();
  }
}
