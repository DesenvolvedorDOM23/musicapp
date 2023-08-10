import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/service/audio_services/audioservices.dart';
import 'package:music_app/core/errors/exceptions.dart';
import 'package:music_app/core/extensions/media_query_extensions.dart';
import 'package:music_app/shared/features/music_app/presentation/widgets/widgets/music_player_widget.dart';
import 'package:music_app/shared/models/music_models.dart';

import '../../../../../core/mixin/snack_barr_mixin.dart';

class MusicPlayerControlles with SnackBarrMixin {
  final AudioServices _audioPlayer;

  MusicPlayerControlles(AudioServices audioPlayer)
      : _audioPlayer = audioPlayer {
    _audioCompleteSubscription = _audioPlayer.onAudioComplete().listen((_) {
      skipTrack();
    });
  }
  //ouve quando a musica acabar para então pular para proxima

  StreamSubscription? _audioCompleteSubscription;

  final RxBool isPlaying = false.obs;

  final RxInt currentMusicDuration = 0.obs;

  final RxnInt currentMusicIndexPlaying = RxnInt();

  int? get getCurrentMusicIndexPlaying => currentMusicIndexPlaying.value;

  final RxList<MusicModel> _playlistPlaying = <MusicModel>[].obs;

  List<MusicModel> get getPlaylistPlaying => _playlistPlaying;

  final List<MusicModel> selectedPlaylist = [];

  Stream<Duration> get getCurrentPositionStream =>
      _audioPlayer.getPositionStream();

  Future<void> seek(int speekToDurationInSeconds) =>
      _audioPlayer.seek(speekToDurationInSeconds);

  void loadPlaylist(
      List<MusicModel> newPlaylist, List<MusicModel> playlistTochange) {
    playlistTochange
      ..clear()
      ..addAll(newPlaylist);
  }

  Future<void> onCallMusicPlayerTryAndCatchFunction(
      Future<void> Function() tryFunction) async {
    try {
      await tryFunction();
    } on AudioplayerException catch (error) {
      showErrorSnackBar(error.message);
    }
  }

  Future<void> playMusic(String url) async {
    onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = true;
      await _audioPlayer.playMusic(url);
    });
  }

  Future<void> stopMusic() async {
    onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayer.stopMusic();
    });
  }

  Future<void> loadMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      //carregar a lista para a caso o usuario tenha mudado o genero musical
      loadPlaylist(selectedPlaylist, _playlistPlaying);

      //para a musica se tiver tocando
      await stopMusic();

      // de o play na musica

      await playMusic(_playlistPlaying[getCurrentMusicIndexPlaying ?? 00].url);
    });
  }

  Future<void> pauseMusic() async {
    return onCallMusicPlayerTryAndCatchFunction(() async {
      isPlaying.value = false;
      await _audioPlayer.pauseMusic();
    });
  }

  //proxima musica
  Future<void> skipTrack() async {
    if (getCurrentMusicIndexPlaying != null) {
      if (getCurrentMusicIndexPlaying! < _playlistPlaying.length) {
        currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! + 1;
      } else {
        //voltar para a musica se estiver na ultima
        currentMusicIndexPlaying.value = 0;
      }
      await loadMusic();
    }
  }

  MusicModel? get getCurrentPlayingMusic {
    if (getCurrentMusicIndexPlaying != null) {
      return _playlistPlaying[getCurrentMusicIndexPlaying!];
    } else {
      return null;
    }
  }

//voltar musica

  Future<void> backTrack() async {
    if (getCurrentMusicIndexPlaying != null &&
        getCurrentMusicIndexPlaying! > 0) {
      currentMusicIndexPlaying.value = currentMusicIndexPlaying.value! - 1;
    } else {
      //voltar para a ultima musica se estiver na primeira
      currentMusicIndexPlaying.value = _playlistPlaying.length - 1;
    }
    await loadMusic();
  }

  void dispose() {
    _audioCompleteSubscription?.cancel();
  }

  //Quando abrir o player se estiver com a musica pausada devemos mostrar onde ela pausou

  Future<void> loadCurrentMusicDuration() async {
    if (!isPlaying.value) {
      currentMusicDuration.value = await _audioPlayer.getCurrentPosition;
    }
  }

  void playerSelectedMusic(BuildContext context, int musicIndex) {
    //atualiza qual o index da musica que sera ouvida da playlist
    currentMusicIndexPlaying.value = musicIndex;

    //carregar e tocar a musica
    loadMusic();
    showMusicPlayer(context);
  }

  Future<void> showMusicPlayer(BuildContext context) async {
    loadCurrentMusicDuration();
    showBottomSheet(
      context: context,
      builder: (_) => Obx(
        () => MusicPlayerWidget(
            music: _playlistPlaying[getCurrentMusicIndexPlaying ?? 0]),
      ),
      constraints: BoxConstraints(
        maxHeight: context.getHeight - context.getTopPadding,
      ),
      backgroundColor: Colors.transparent,
      enableDrag: true,
    );
  }
}
