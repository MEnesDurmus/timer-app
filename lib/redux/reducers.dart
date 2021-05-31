import 'package:flutter_redux/flutter_redux.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is TimerChangedAction)
    return AppState(initialtimer: action.changedtimer);
  if (action is StartStopTimerAction) {
    return AppState(
        initialtimer: state.initialtimer,
        cancelFunction: action.cancelFunction);
  }
  return state;
}
