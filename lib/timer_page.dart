import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timer_app/custom_button.dart';
import 'package:timer_app/methods.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

class TimerPage extends StatelessWidget {
  Color getColor(AppState state) {
    if (!state.isStarted)
      return Colors.blueAccent;
    else if (!state.isPaused)
      return Colors.orangeAccent;
    else
      return Colors.blueAccent;
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
                          InitialTimer.time = changedtimer;
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
                    CustomButton(
                      text: (() {
                        if (!state.isStarted)
                          return 'Start';
                        else if (!state.isPaused)
                          return 'Pause';
                        else
                          return 'Resume';
                      }()),
                      color: getColor(state),
                      onPressed: () {
                        if (!state.isStarted) {
                          if (InitialTimer.time.inMinutes == 0) return;
                          store
                              .dispatch(StartTimerAction(InitialTimer.time, () {
                            store.dispatch(StopTimerAction());
                          }, startTimer(store)));
                        } else if (!state.isPaused)
                          store.dispatch(PauseTimerAction());
                        else
                          store.dispatch(ResumeTimerAction(startTimer(store)));
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }
}

class InitialTimer {
  static Duration time = new Duration();
}
