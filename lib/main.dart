import 'package:flutter/material.dart';
import 'package:stopwatch_timer/pomodoro_timer.dart';
import 'package:stopwatch_timer/stopwatch.dart';
import 'package:stopwatch_timer/timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Flutter Project'),
            bottom: TabBar(
              tabs: [Text('Timer'), Text('Pomodoro')],
              labelPadding: EdgeInsets.only(bottom: 10),
              labelStyle: TextStyle(fontSize: 18.0),
              unselectedLabelColor: Colors.white54,
            ),
          ),
          body: TabBarView(children: [ TimerPage(), PomodoroTimer()]),
        ),
      ),
    );
  }
}
