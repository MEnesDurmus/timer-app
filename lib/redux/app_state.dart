import 'dart:async';

class AppState {
  final Duration initialtimer;
  final Function()? cancelFunction;
  final Duration timeLeft;
  final Timer? timer;
  final bool isPaused;
  AppState({
    required this.initialtimer,
    this.cancelFunction,
    this.timeLeft = const Duration(),
    this.timer,
    this.isPaused = false,
  });

  bool get isStarted {
    return cancelFunction != null;
  }

  String get timeLeftinString {
    int inSeconds = timeLeft.inSeconds;
    String hours = (inSeconds / 3600).floor().to2Digits();
    String minutes = ((inSeconds % 3600) / 60).floor().to2Digits();
    String seconds = (inSeconds % 60).to2Digits();
    if (inSeconds >= 3600)
      return "$hours:$minutes:$seconds";
    else
      return "$minutes:$seconds";
  }

  factory AppState.fromState(
    AppState state, {
    Duration? initialtimer,
    Function()? cancelFunction,
    Duration? timeLeft,
    Timer? timer,
    bool? isPaused,
  }) {
    return AppState(
      initialtimer: initialtimer ?? state.initialtimer,
      cancelFunction: cancelFunction ?? state.cancelFunction,
      timeLeft: timeLeft ?? state.timeLeft,
      timer: timer ?? state.timer,
      isPaused: isPaused ?? state.isPaused,
    );
  }

  AppState.initialState()
      : initialtimer = Duration(),
        cancelFunction = null,
        timeLeft = Duration(),
        timer = null,
        isPaused = false;
}

extension IntParsing on int {
  String to2Digits() {
    if (this > 9)
      return this.toString();
    else
      return "0$this";
  }
}
