import 'package:flutter/material.dart';
import 'package:tween_wellness/models/user.dart';
import 'package:tween_wellness/pages/activity_session.dart';
import 'package:tween_wellness/pages/home.dart';
import 'package:tween_wellness/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String act_name1 = "Lunges";
String act_name2 = "Squats";
String act_name3 = "Push Ups";
int one_set = 1;
int twenty_reps = 20;
int sixty_sec = 60;
int points_1 = 100;
int points_2 = 250;
int points_3 = 500;
int x1 = 0;

class New_Activities extends StatefulWidget {
  const New_Activities({Key? key}) : super(key: key);

  @override
  State<New_Activities> createState() => _New_ActivitiesState();
}

class _New_ActivitiesState extends State<New_Activities> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("New Activities"),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              //ACTIVITY 1 - LUNGES============================================
              Container(
                width: 220,
                height: 150,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: EdgeInsets.fromLTRB(95, 10, 0, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF959595)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFB2FFA6),
                ),
                child: Column(
                  children: <Widget>[
                    Text("Activity Name: " +
                        act_name1 +
                        "\nSets: " +
                        one_set.toString() +
                        "\nReps: " +
                        twenty_reps.toString() +
                        "\nTime: " +
                        sixty_sec.toString() +
                        " seconds" +
                        "\nCompletion Points: " +
                        points_1.toString() +
                        " points"),
                    ElevatedButton( //START ACTIVITY LUNGES
                        onPressed: () {
                          AlertDialog alert1 = AlertDialog(
                            title: Text("Activity Confirmation"),
                            content: Text(
                                "Do you want to start activity: $act_name1?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    x1 = 1;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Activity_Session1()));
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); //closes dialog
                                  },
                                  child: Text("No")),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert1;
                              });
                        },
                        child: Text("Start Activity")),
                  ],
                ),
              ),
              //ACTIVITY 1 - LUNGES============================================

              //ACTIVITY 2 - SQUATS============================================
              Container(
                width: 220,
                height: 150,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: EdgeInsets.fromLTRB(95, 10, 0, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF959595)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFB2FFA6),
                ),
                child: Column(
                  children: <Widget>[
                    Text("Activity Name: " +
                        act_name2 +
                        "\nSets: " +
                        one_set.toString() +
                        "\nReps: " +
                        twenty_reps.toString() +
                        "\nTime: " +
                        sixty_sec.toString() +
                        " seconds" +
                        "\nCompletion Points: " +
                        points_2.toString() +
                        " points"),
                    ElevatedButton( //START ACTIVITY SQUATS
                        onPressed: () {
                          //DIALOG BOX=========================================
                          AlertDialog alert2 = AlertDialog(
                            title: Text("Activity Confirmation"),
                            content: Text(
                                "Do you want to start activity: $act_name2?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    x1 = 2;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Activity_Session1()));
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); //closes dialog
                                  },
                                  child: Text("No")),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert2;
                              });
                          //DIALOG BOX=========================================
                        },
                        child: Text("Start Activity")),
                  ],
                ),
              ),
              //ACTIVITY 2 - SQUATS============================================

              //ACTIVITY 3 - PUSH UPS==========================================
              Container(
                width: 220,
                height: 150,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: EdgeInsets.fromLTRB(95, 10, 0, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF959595)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFFB2FFA6),
                ),
                child: Column(
                  children: <Widget>[
                    Text("Activity Name: " +
                        act_name3 +
                        "\nSets: " +
                        one_set.toString() +
                        "\nReps: " +
                        twenty_reps.toString() +
                        "\nTime: " +
                        sixty_sec.toString() +
                        " seconds" +
                        "\nCompletion Points: " +
                        points_3.toString() +
                        " points"),
                    ElevatedButton( //START ACTIVITY PUSH UPS
                        onPressed: () {
                          //DIALOG BOX=========================================
                          AlertDialog alert3 = AlertDialog(
                            title: Text("Activity Confirmation"),
                            content: Text(
                                "Do you want to start activity: $act_name3?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    x1 = 3;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Activity_Session1()));
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); //closes dialog
                                  },
                                  child: Text("No")),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert3;
                              });
                          //DIALOG BOX=========================================
                        },
                        child: Text("Start Activity")),
                  ],
                ),
              ),
              //ACTIVITY 3 - PUSH UPS==========================================
              Container(
                margin: EdgeInsets.fromLTRB(100, 10, 0, 0),
                child: ElevatedButton( //BACK TO MY ACTIVITIES PAGE
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Back")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
