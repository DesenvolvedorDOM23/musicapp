import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_app/core/app/service/audio_services/audioservicesimpl.dart';
import 'package:music_app/core/errors/exceptions.dart';

class MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  late MockAudioPlayer mockAudioPlayer;
  late AudioServiceImpl audioPlayerServicesImpl;

  setUp(() {
    mockAudioPlayer = MockAudioPlayer();
    audioPlayerServicesImpl = AudioServiceImpl(audioPlayer: mockAudioPlayer);
  });

  test('Should get current position Music', () async {
    when(() => mockAudioPlayer.getCurrentPosition())
        .thenAnswer((_) => Future.value(const Duration(seconds: 10)));
    final position = await audioPlayerServicesImpl.getCurrentPosition;
    verify(
      () => mockAudioPlayer.getCurrentPosition(),
    ).called(1);

    expect(position, equals(10));
  });

  test('should get audio complete stream', () {
    final mockStreamCtrl = StreamController<Duration>();
    when(() => mockAudioPlayer.onDurationChanged)
        .thenAnswer((_) => mockStreamCtrl.stream);
    final positionStream = audioPlayerServicesImpl.getPositionStream();
    verify(() => mockAudioPlayer.onDurationChanged).called(1);
    expect(positionStream, equals(mockStreamCtrl.stream));
  });

  group('Pause Music', () {
    test('should successfully pause music', () async {
      when(() => mockAudioPlayer.pause()).thenAnswer((_) => Future.value());

      await audioPlayerServicesImpl.pauseMusic();
      verify(() => mockAudioPlayer.pause()).called(1);
    });
  });

  test('should fail on pause music', () {
    when(() => mockAudioPlayer.pause()).thenThrow(Exception());
    final futurePause = audioPlayerServicesImpl.pauseMusic();

    verify(() => mockAudioPlayer.pause()).called(1);
    expect(futurePause, throwsA(isA<AudioplayerException>()));
  });
}
