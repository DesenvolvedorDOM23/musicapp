import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_list/presentation/screens/widgets/text_widget.dart';

import 'app_music_error_widget.dart';

class ScreenWidget extends StatelessWidget {
  final bool isloading;
  final String? error;
  final String title;
  final Widget child;
  final VoidCallback? onTryAgain;

  const ScreenWidget(
      {required this.isloading,
      required this.title,
      required this.child,
      this.onTryAgain,
      this.error,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget.bold(title),
      ),
      body: ColoredBox(
        color: MusicAppColors.primaryColor,
        child: SizedBox.expand(
            child: isloading || error != null
                ? Center(
                    child: isloading
                        ? CircularProgressIndicator()
                        : AppMusicErrorWidget(
                            error: error!,
                            onTryAgain: onTryAgain,
                          ),
                  )
                : child),
      ),
    );
  }
}
