abstract class Action {}

class TimerChangedAction extends Action {
  final Duration changedtimer;
  TimerChangedAction(this.changedtimer);
}

class StartStopTimerAction extends Action {
  final MyFunction? cancelFunction;

  StartStopTimerAction([this.cancelFunction]);
}

typedef void MyFunction();
