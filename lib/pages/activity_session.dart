import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
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
int update_act1 = 0;
int update_pts1 = 0;
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

  insertCompletedActivity() {
    activityUser
        .doc(currentUser.id)
        .collection("activitiesCompleted")
        .doc()
        .set({
      "activityName": act_session,
      "sets": sets_session,
      "reps": reps_session,
      "duration": time_session,
      "points earned": points_session,
      "completion DateTime": DateTime.now(),
    });
  }

  getCompletedActivityAndPoints() async {
    DocumentSnapshot doc1 = await activityUser.doc(currentUser.id).get();
    final int update_act2 = doc1.get("activitiesDone");
    final int update_pts2 = doc1.get("totalPoints");
    update_act1 = update_act2;
    update_pts1 = update_pts2;
    updateCompletedActivity();
  }

  updateCompletedActivity() {
    activityUser.doc(currentUser.id).update({
      "activitiesDone": update_act1 + 1,
      "totalPoints": update_pts1 + points_session,
    });
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
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
        getCompletedActivityAndPoints();
        insertCompletedActivity();
        //DIALOG BOX==========================================================
        AlertDialog alert1 = AlertDialog(
          title: Text("Activity Completed"),
          content: Text("Activity Completed for $act_session"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text("Ok")),
          ],
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert1;
            });
        //DIALOG BOX==========================================================
      }
    });
  }

  Widget buildButtons() {
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
