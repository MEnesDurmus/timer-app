class AppState {
  final Duration initialtimer;
  final Function()? cancelFunction;
  AppState({
    required this.initialtimer,
    this.cancelFunction,
  });

  bool get isStarted {
    return cancelFunction != null;
  }

  AppState.initialState()
      : initialtimer = new Duration(),
        cancelFunction = null;
}
