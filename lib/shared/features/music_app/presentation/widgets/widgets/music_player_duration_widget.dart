import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/core/extensions/duration_extensuins.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/text_widget.dart';
import 'package:music_app/shared/features/music_app/presentation/controllers/musica_app_controlleres.dart';

class MusicPlayerDurationWidget extends StatefulWidget {
  final int duration;
  const MusicPlayerDurationWidget({
    super.key,
    required this.duration,
  });

  @override
  State<MusicPlayerDurationWidget> createState() =>
      _MusicPlayerDurationWidgetState();
}

class _MusicPlayerDurationWidgetState extends State<MusicPlayerDurationWidget> {
  final sliderValueRx = RxnDouble();
  @override
  Widget build(BuildContext context) {
    final musicplayercontroller = Get.find<MusicPlayerControlles>();
    return StreamBuilder(
        stream: musicplayercontroller.getCurrentPositionStream,
        builder: (context, AsyncSnapshot<Duration> snapshot) {
          final seconds = snapshot.data?.inSeconds ??
              musicplayercontroller.currentMusicDuration.value;
          return Column(
            children: [
              Obx(
                () => Slider(
                  value: (sliderValueRx.value ?? seconds / widget.duration)
                      .clamp(0, 1),
                  onChanged: (double sliderValue) async {
                    await musicplayercontroller.seek(
                      (sliderValue * widget.duration).floor(),
                    );
                    sliderValueRx.value = null;
                  },
                  activeColor: MusicAppColors.secundaryColor,
                  inactiveColor: Colors.grey.shade600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget.small(
                    seconds.fromSeconsToMinutesString,
                  ),
                  TextWidget.small(
                      '-${(widget.duration - seconds).fromSeconsToMinutesString}'),
                ],
              )
            ],
          );
        });
  }
}
