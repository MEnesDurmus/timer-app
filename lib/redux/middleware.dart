import 'package:timer_app/methods.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';
import 'package:redux/redux.dart';

class AppMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    if (action is PauseTimerAction) {
      store.state.timer?.cancel();
      store.dispatch(PauseTimerActionCleaned());
    }
    // if (action is ResumeTimerAction) {
    //   store.dispatch(ResumeTimerActionCleaned(startTimer(store)));
    // }
    next(action);
  }
}
