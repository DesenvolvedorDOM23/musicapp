extension DurationExtensuins on int {
  String get fromSeconsToMinutesString {
    final int minutes = (this / 60).floor();
    final int seconds = this % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
