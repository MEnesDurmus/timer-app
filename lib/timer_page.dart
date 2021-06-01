import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:timer_app/custom_button.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

class TimerPage extends StatelessWidget {
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
                          StoreProvider.of<AppState>(context)
                              .dispatch(TimerChangedAction(changedtimer));
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
                      text: 'Start',
                      color: Colors.blueAccent,
                      onPressed: () {
                        if (state.initialtimer.inMinutes == 0) return;
                        store.dispatch(StartTimerAction(() {
                          store.dispatch(StopTimerAction());
                        }, startTimer(store)));
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
