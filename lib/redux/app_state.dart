import 'dart:async';

class AppState {
  final Duration initialtimer;
  final Function()? cancelFunction;
  final Duration timeLeft;
  final Timer? timer;
  AppState(
      {required this.initialtimer,
      this.cancelFunction,
      this.timeLeft = const Duration(),
      this.timer});

  bool get isStarted {
    return cancelFunction != null;
  }

  String get timeLeftinString {
    int inSeconds = timeLeft.inSeconds;
    String hours = (inSeconds / 3600).floor().to2Digits();
    String minutes = (inSeconds / 60).floor().to2Digits();
    String seconds = (inSeconds % 60).to2Digits();
    if (inSeconds >= 3600)
      return "$hours:$minutes:$seconds";
    else
      return "$minutes:$seconds";
  }

  AppState.initialState()
      : initialtimer = Duration(),
        cancelFunction = null,
        timeLeft = Duration(),
        timer = null;
}

extension IntParsing on int {
  String to2Digits() {
    if (this > 9)
      return this.toString();
    else
      return "0$this";
  }
}
