import 'package:animator/animator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tween_wellness/models/user.dart';
import 'package:tween_wellness/pages/home.dart';
import 'package:tween_wellness/pages/new_activities.dart';
import 'package:tween_wellness/pages/activity_session.dart';
import 'package:tween_wellness/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tween_wellness/widgets/progress.dart';

String name1 = "";
String name2 = "";
String done1 = "";
String points1 = "";

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  void initState() {
    super.initState();
    getNameUser1(); //GETS USER'S NAME FROM FIRESTORE
    checkUser(); //CHECKS IF USER DATA IS IN ACTIVITIES COLLECTION IN FIRESTORE
  }

  //TO GET NAME OF USER ACCORDING TO ID===================================
  getNameUser1() async {
    DocumentSnapshot doc1 = await usersRef.doc(currentUser.id).get();
    final String description = doc1.get("displayName");
    name1 = description;
    name2 = name1;
  }
  //TO GET NAME OF USER ACCORDING TO ID===================================

  //TO CHECK AND CREATE ACTIVITIES COLLECTION IN FIRESTORE================
  checkUser() async {
    DocumentSnapshot doc2 = await activityUser.doc(currentUser.id).get();
    if (doc2.exists) {
    } else {
      setState(() {
        activityUser.doc(currentUser.id).set({
          "username": name2,
          "activitiesDone": 0,
          "totalPoints": 0,
        });
      });
    }
  }
  //TO CHECK AND CREATE ACTIVITIES COLLECTION IN FIRESTORE================

  //TO GET NUMBER OF COMPLETED ACTIVITY AND TOTAL POINTS EARNED=============
  getActStatistics() async {
    DocumentSnapshot doc3 = await activityUser.doc(currentUser.id).get();
    if (!doc3.exists) {
    } else {
      final int actDone1 = doc3.get("activitiesDone");
      final int actTotalPoints1 = doc3.get("totalPoints");
      done1 = actDone1.toString();
      points1 = actTotalPoints1.toString();
    }
  }
  //TO GET NUMBER OF COMPLETED ACTIVITY AND TOTAL POINTS EARNED=============

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.orange,
        appBar: header(context, titleText: "My Activities"),
        body: Scaffold(
          backgroundColor: Colors.orange,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Hi " + name1 + "! Let's check your activity"),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                //ROW 1 (START)=================================================
                Row(
                  children: [
                    //FOR COMPLETED ACTIVITIES (START)==========================
                    Container(
                      width: 115,
                      height: 145,
                      margin: EdgeInsets.fromLTRB(85, 30, 0, 0),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF959595)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFFB2FFA6),
                      ),
                      child: Text(
                        'Completed Activities\n\n' + done1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //FOR COMPLETED ACTIVITIES (END)============================

                    //FOR TOTAL POINTS (START)==================================
                    Container(
                      width: 115,
                      height: 145,
                      margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF959595)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFFB2FFA6),
                      ),
                      child: Text(
                        'Total Points Earned\n\n' + points1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //FOR TOTAL POINTS (END)====================================
                  ],
                ),
                //ROW 1 (END)===================================================

                //INNER COLUMN (START)==========================================
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton( //NEW ACTIVITY BUTTON
                        onPressed: () {
                          //GOES TO NEW ACTIVITY
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => New_Activities()))
                              .then((value) {
                            setState(() { //FOR WHEN COMING BACK TO THIS PAGE
                              getNameUser1();
                              checkUser();
                              getActStatistics();
                            });
                          });
                        },
                        child: Text("New Activity"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton( //REFRESH BUTTON
                        onPressed: () {
                          //REFRESH PAGE
                          setState(() { //FOR WHEN COMING BACK TO THIS PAGE
                            getNameUser1();
                            checkUser();
                            getActStatistics();
                          });
                        },
                        child: Text("Refresh"),
                      ),
                    ),
                  ],
                ),
                //INNER COLUMN (END)============================================
              ],
            ),
          ),
        ),
      ),
    );
  }
}
