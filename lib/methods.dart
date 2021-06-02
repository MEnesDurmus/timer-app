import 'dart:async';

import 'package:redux/redux.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

Timer startTimer(Store<AppState> store) {
  const oneSec = const Duration(seconds: 1);
  return Timer.periodic(
    oneSec,
    (Timer timer) {
      if (store.state.timeLeft.inSeconds == 0) {
        timer.cancel();
        store.dispatch(StopTimerAction());
      } else {
        store.dispatch(TimerCountdownAction(
            Duration(seconds: store.state.timeLeft.inSeconds - 1)));
      }
    },
  );
}
