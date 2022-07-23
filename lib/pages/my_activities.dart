import 'package:animator/animator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tween_wellness/models/user.dart';
import 'package:tween_wellness/pages/home.dart';
import 'package:tween_wellness/widgets/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tween_wellness/widgets/progress.dart';

String name1 = "";
String name2 = "";
String done1 = "";
String progress1 = "";
String points1 = "";

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  void initState() {
    super.initState();
    getNameUser1();
    checkUser();
  }

  //TO CHECK NAME OF USER ACCORDING TO ID===================================
  getNameUser1() async {
    DocumentSnapshot doc1 = await usersRef.doc(currentUser.id).get();
    final String description = doc1.get("displayName");
    setState(() {
      name1 = description;
      name2 = name1;
    });
  }
  //TO CHECK NAME OF USER ACCORDING TO ID===================================

  //TO CHECK AND CREATE DATA INTO ACTIVITIES TABLE OF FIRESTORE=============
  checkUser() async {
    DocumentSnapshot doc2 = await activityUser.doc(currentUser.id).get();
    if (doc2.exists) {
      getActStatistics();
    } else {
      setState(() {
        activityUser.doc(currentUser.id).set({
          "username": name2,
          "activitiesDone": 0,
          "activitiesInProgress": 0,
          "totalPoints": 0,
        });
        getActStatistics();
      });
    }
  }
  //TO CHECK AND CREATE DATA INTO ACTIVITIES TABLE OF FIRESTORE=============

  getActStatistics() async {
    DocumentSnapshot doc3 = await activityUser.doc(currentUser.id).get();
    if (!doc3.exists) {
    } else {
      setState(() {
        final int actDone1 = doc3.get("activitiesDone");
        final int actProgress1 = doc3.get("activitiesInProgress");
        final int actTotalPoints1 = doc3.get("totalPoints");
        done1 = actDone1.toString();
        progress1 = actProgress1.toString();
        points1 = actTotalPoints1.toString();
      });
    }
  }

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
                      margin: EdgeInsets.fromLTRB(22, 30, 0, 0),
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

                    //FOR IN PROGRESS ACTIVITES (START)=========================
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
                        'In Progress Activities\n\n' + progress1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //FOR IN PROGRESS ACTIVITES (END)===========================

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
                      child: ElevatedButton(
                        onPressed: () {
                          //GOES TO NEW ACTIVITY
                        },
                        child: Text("New Activity"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          //GOES TO NEW ACTIVITY
                        },
                        child: Text("Activity History"),
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
