import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int hour = 0;
  int minutes = 0;
  int seconds = 0;
  bool started = true;
  bool stopped = false;
  String timeToDisplay = '';
  int timeForTimer = 0;
  bool stopTimer = false;

  Widget picker({
    required String text,
    required int val,
    required int maxVal,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          NumberPicker(
            minValue: 0,
            maxValue: maxVal,
            value: val,
            onChanged: (value) {
              if (text == 'HH') {
                setState(() {
                  hour = value;
                });
              }
              if (text == 'MM') {
                setState(() {
                  minutes = value;
                });
              }
              if (text == 'SS') {
                setState(() {
                  seconds = value;
                });
              }
            },
          )
        ],
      ),
    );
  }

  // Widget button(
  //     {required VoidCallback fn, required Color color, required String text}) {
  //   return TextButton(
  //     onPressed: () => fn,
  //     child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
  //     style: TextButton.styleFrom(
  //         shape: StadiumBorder(),
  //         primary: Colors.white,
  //         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
  //         backgroundColor: color),
  //   );
  // }

   start() {
    setState(() {
      started = false;
      stopped= true;
    });

    timeForTimer = ((hour * 60 * 60) + minutes * 60 + seconds);

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || stopTimer == true) {
          t.cancel();
          stopTimer = false;
          if(timeForTimer < 1){
            hour = 0;
            minutes = 0;
            seconds = 0;
            timeForTimer = 0;
            timeToDisplay = timeForTimer.toString();
            setState(() {
              stopped = false;
              started = true;
            });
          }

        }else if(timeForTimer < 60){
          hour = timeForTimer ~/3600;
          minutes = timeForTimer ~/60;
          seconds = timeForTimer;
          timeToDisplay = '0'+ ':' + '0' + ':' + timeForTimer.toString();
          timeForTimer = timeForTimer - 1;



        }else if(timeForTimer < 3600){
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60*m);

          hour = timeForTimer ~/3600;
          minutes = m;
          seconds = s;
          timeToDisplay ='0'+ ':' + m.toString() + ':' + s.toString();
          timeForTimer = timeForTimer - 1;
        }
        else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/60 ;
          int s = t -(m *60);

          hour = h;
          minutes = m;
          seconds = s;
          timeToDisplay = h.toString()+ ':' + m.toString() + ':' + s.toString() ;
          timeForTimer = timeForTimer - 1;
        }

      });
    });
  }

  stop(){
    setState(() {
      started = true;
      stopped = false;
      stopTimer = true;
    });
  }

  restart(){

    setState(() {
      started = false;
      stopped = false;
    });

    timeForTimer = 0;
    timeToDisplay ='';
    // hour = 0;
    // minutes = 0;
    // seconds = 0;

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                picker(text: 'HH', maxVal: 23, val: hour),
                picker(text: 'MM', maxVal: 59, val: minutes),
                picker(text: 'SS', maxVal: 59, val: seconds),
              ],
            )),
        Expanded(
          flex: 1,
          child: Text(
            timeToDisplay,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
          ),
        ),
        Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: started?  start : restart,
                  child: Text(started?'Start' : 'Restart',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: TextButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      backgroundColor:started? Colors.green : Colors.orangeAccent),
                ),
                TextButton(
                  onPressed: stopped?  stop : null,
                  child: Text('Stop',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: TextButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.white,
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      backgroundColor:stopped? Colors.red : Colors.grey),
                ),
              ],
            ))
      ],
    );
  }
}
