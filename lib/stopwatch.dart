import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              '00:00:00',
              style: TextStyle(fontSize: 60),
            ),
          ),
          flex: 6,
        ),
        Expanded(
          flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Stop',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: TextButton.styleFrom(
                shape: StadiumBorder(),
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 35)),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.teal[800],
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 35)),
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.only(bottom: 48.0),
          child: TextButton(
          onPressed: () {},
          child: Text(
          'Start',
          style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          style: TextButton.styleFrom(
            shape: StadiumBorder(),
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60)),
          ),
        )
      ],
    );
  }
}
