import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';
import 'package:redux/redux.dart';

class AppMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    // if (action is Action) {
    //   store.dispatch(action);
    // }
    next(action);
  }
}
