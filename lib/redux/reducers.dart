import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is StartTimerAction) {
    return AppState(
      initialtimer: action.initialTimer,
      cancelFunction: action.cancelFunction,
      timeLeft: action.initialTimer,
      timer: action.timer,
    );
  }
  if (action is StopTimerAction) {
    return AppState(
      initialtimer: state.initialtimer,
      cancelFunction: null,
      timeLeft: Duration(),
    );
  }
  if (action is TimerCountdownAction) {
    return AppState.fromState(state, timeLeft: action.timeLeft);
  }
  if (action is PauseTimerActionCleaned) {
    return AppState.fromState(state, isPaused: !state.isPaused);
  }
  if (action is ResumeTimerAction) {
    return AppState.fromState(
      state,
      isPaused: !state.isPaused,
      timer: action.timer,
    );
  }
  return state;
}
