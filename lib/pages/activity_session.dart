import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tween_wellness/models/user.dart';
import 'package:tween_wellness/pages/home.dart';
import 'package:tween_wellness/pages/my_activities.dart';
import 'package:tween_wellness/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tween_wellness/pages/my_activities.dart';
import 'package:tween_wellness/pages/new_activities.dart';

String act_session = "";
int sets_session = 0;
int reps_session = 0;
int time_session = 0;
int points_session = 0;
int countdowntime = 0;
Timer? timer;

class Activity_Session1 extends StatefulWidget {
  const Activity_Session1({Key? key}) : super(key: key);

  @override
  State<Activity_Session1> createState() => _Activity_Session1State();
}

class _Activity_Session1State extends State<Activity_Session1> {
  int seconds = 60;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    if (x1 == 1) {
      act_session = act_name1;
      sets_session = one_set;
      reps_session = twenty_reps;
      time_session = sixty_sec;
      points_session = points_1;
    } else if (x1 == 2) {
      act_session = act_name2;
      sets_session = one_set;
      reps_session = twenty_reps;
      time_session = sixty_sec;
      points_session = points_2;
    } else if (x1 == 3) {
      act_session = act_name3;
      sets_session = one_set;
      reps_session = twenty_reps;
      time_session = sixty_sec;
      points_session = points_3;
    }
    countdowntime = time_session;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        appBar: header(context, titleText: "Activity Session"),
        body: Scaffold(
          backgroundColor: Colors.orange,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Activity Name: " + act_session),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTime(),
                  const SizedBox(height: 80),
                  buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(microseconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }

  Widget buildButtons() {
    final isCompleted = timer == 0;
    return ElevatedButton(
        onPressed: () {
          startTimer();
        },
        child: Text("Start Timer"));
  }

  Widget buildTime() {
    return Text(
      '$seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 80,
      ),
    );
  }
}
