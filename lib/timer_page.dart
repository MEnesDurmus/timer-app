import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timer_app/custom_button.dart';
import 'package:timer_app/redux/actions.dart';
import 'package:timer_app/redux/app_state.dart';

class TimerPage extends StatelessWidget {
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
                        child: Text('Timer Started!'),
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
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CustomButton(
                      text: 'Cancel',
                      onPressed: state.cancelFunction,
                      color: Colors.redAccent,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onPressed: () {
                            if (state.initialtimer.inMinutes == 0) return;
                            store.dispatch(StartStopTimerAction(() {
                              store.dispatch(StartStopTimerAction());
                            }));
                          },
                          text: 'Start',
                          color: Colors.blueAccent,
                        ),
                      ],
                    ))
                  ],
                ),
              )
            ],
          );
        });
  }
}
