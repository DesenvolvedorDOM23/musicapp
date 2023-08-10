import 'package:flutter/material.dart';
import 'package:music_app/core/app/music_app_text.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TextWidget(

    this.text,
     {
    this.style,
    this.textAlign,
    super.key,
  }
  );

  TextWidget.bold(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getBoldStyle;

  TextWidget.title(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getTitleStyle;

  TextWidget.normal(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getNormalStyle;

  TextWidget.small(
    this.text, {
    super.key,
    TextStyle? textStyle,
    this.textAlign,
  }) : style = textStyle ?? MusicAppTextStyle.getSmallStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
    );
  }
}
