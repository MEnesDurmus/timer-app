import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is TimerChangedAction)
    return AppState(initialtimer: action.changedtimer);
  if (action is StartTimerAction) {
    return AppState(
      initialtimer: state.initialtimer,
      cancelFunction: action.cancelFunction,
      timeLeft: state.initialtimer,
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
    return AppState(
        initialtimer: state.initialtimer,
        timeLeft: action.timeLeft,
        cancelFunction: state.cancelFunction);
  }
  return state;
}
