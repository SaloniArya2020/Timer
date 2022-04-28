import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({Key? key}) : super(key: key);

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {

  bool isStartPressed = true;
  bool isPausePressed = false;
  bool isStopped = false;
  int minute = 25;
  int second = 00;
  int timeForTimer = 0;
  String timeToDisplay = '25 : 00';

  start(){
    if (!mounted) return;
    setState(() {
      isStartPressed = false;
      isPausePressed = true;
    });


    timeForTimer = (minute * 60) + second;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if(timeForTimer < 1 || isStopped == true){
          if(timeForTimer < 1){
            FlutterRingtonePlayer.play(
              android: AndroidSounds.notification,
              ios: IosSounds.glass,
              looping: false, // Android only - API >= 28
              volume: 5, // Android only - API >= 28
              asAlarm: true,
            );
            timeToDisplay = '25:00';
            minute = 25;
            second= 00;
             isStartPressed = true;
             isPausePressed = false;
          }
         if(isStopped){
           FlutterRingtonePlayer.stop();
         }
          t.cancel();
          isStopped = false;
        }else if(timeForTimer < 60){
          minute = 0;
          second = timeForTimer;
          timeForTimer -= 1;
          timeToDisplay = '00 : ${second.toString()}';
        }else{
          int m = timeForTimer~/60;
          int s = timeForTimer - (m * 60);
          minute = m;
          second = s;
          timeForTimer -= 1;
          timeToDisplay = '${minute.toString()} : ${second.toString()}';
        }
        // else{
        //   timeForTimer -= 1;
        // }
        // timeToDisplay = timeForTimer.toString();
      });
      // print(timeForTimer);
    });
  }

  stop(){
    setState(() {
      isStartPressed = true;
      isPausePressed = false;
      isStopped = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              timeToDisplay,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: isStartPressed ? start : null,
                child: Text(
                  'Start',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: TextButton.styleFrom(
                    backgroundColor:isStartPressed ? Colors.teal[600] : Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50)),
              ),
              TextButton(
                onPressed: isPausePressed? stop: null,
                child: Text(
                  'Pause',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: TextButton.styleFrom(
                    backgroundColor:isPausePressed? Colors.deepOrangeAccent : Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
