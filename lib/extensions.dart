extension DurationParsing on Duration {
  String durationToString() {
    int inSeconds = this.inSeconds;
    String hours = (inSeconds / 3600).floor().to2Digits();
    String minutes = (inSeconds / 60).floor().to2Digits();
    String seconds = (inSeconds % 60).to2Digits();
    if (inSeconds >= 3600)
      return "$hours:$minutes:$seconds";
    else
      return "$minutes:$seconds";
  }
}

extension IntParsing on int {
  String to2Digits() {
    if (this > 9)
      return this.toString();
    else
      return "0$this";
  }
}
