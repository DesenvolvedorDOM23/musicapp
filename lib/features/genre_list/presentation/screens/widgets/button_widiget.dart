import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/text_widget.dart';

class ButtonWidiget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const ButtonWidiget({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: MusicAppColors.tertiaryColor,
        ),
        child: TextWidget.bold(title));
  }
}
