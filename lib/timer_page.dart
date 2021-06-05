import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:timer_app/custom_button.dart';
import 'package:timer_app/methods.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

class TimerPage extends StatelessWidget {
  static Duration time = new Duration();

  CustomButton getButton(Store<AppState> store) {
    var state = store.state;
    if (!state.isStarted)
      return CustomButton(
        text: 'Start',
        color: Colors.blueAccent,
        onPressed: () {
          if (time.inMinutes == 0) return;
          store.dispatch(StartTimerAction(time, () {
            store.dispatch(StopTimerAction());
          }, startTimer(store)));
        },
      );
    else if (!state.isPaused)
      return CustomButton(
        text: 'Pause',
        color: Colors.orangeAccent,
        onPressed: () {
          store.dispatch(PauseTimerAction());
        },
      );
    else
      return CustomButton(
        text: 'Resume',
        color: Colors.blueAccent,
        onPressed: () {
          store.dispatch(ResumeTimerAction(startTimer(store)));
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var store = StoreProvider.of<AppState>(context);
          return Column(
            children: [
              SizedBox(height: 30),
              Container(
                height: 250,
                child: state.isStarted
                    ? Center(
                        child: Text(
                          "${state.timeLeftinString}",
                          style: TextStyle(fontSize: 90),
                        ),
                      )
                    : CupertinoTimerPicker(
                        mode: CupertinoTimerPickerMode.hm,
                        minuteInterval: 1,
                        secondInterval: 1,
                        initialTimerDuration: state.initialtimer,
                        onTimerDurationChanged: (Duration changedtimer) {
                          time = changedtimer;
                        },
                      ),
              ),
              Divider(color: Colors.black),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      text: 'Cancel',
                      color: Colors.redAccent,
                      onPressed: state.cancelFunction,
                    ),
                    getButton(store)
                  ],
                ),
              )
            ],
          );
        });
  }
}
