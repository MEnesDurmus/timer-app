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
  final Duration initialTimer;
  final MyFunction cancelFunction;
  final Timer timer;
  StartTimerAction(this.initialTimer, this.cancelFunction, this.timer);
}

class StopTimerAction extends Action {
  StopTimerAction();
}

class PauseTimerAction extends Action {}

class ResumeTimerAction extends Action {
  final Timer timer;

  ResumeTimerAction(this.timer);
}

class PauseTimerActionCleaned extends Action {}

class ResumeTimerActionCleaned extends Action {}

typedef void MyFunction();
