import 'dart:async';

abstract class Action {}

class TimerChangedAction extends Action {
  final Duration changedtimer;
  TimerChangedAction(this.changedtimer);
}

class TimerCountdownAction extends Action {
  final Duration timeLeft;
  TimerCountdownAction(this.timeLeft);
}

class StartTimerAction extends Action {
  final MyFunction cancelFunction;
  final Timer timer;
  StartTimerAction(this.cancelFunction, this.timer);
}

class StopTimerAction extends Action {
  StopTimerAction();
}

typedef void MyFunction();
