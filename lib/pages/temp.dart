import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Activites1 extends StatefulWidget {
  const Activites1({Key? key}) : super(key: key);

  @override
  State<Activites1> createState() => _Activites1State();


}

class _Activites1State extends State<Activites1> {
  String _done1 = '';
  final _database1 = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    _database1.child('User Details').child('User1').child('activities done').onValue.listen((event) {
      final String description = event.snapshot.value.toString();
      setState(() {
        _done1 = description;
      });
    });



  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Activities Page'),
          backgroundColor: Colors.greenAccent[400],
        ),
        body: Scaffold(
          appBar: AppBar(
            title: Text('Hello User\nLets check your activity'),
            backgroundColor: Colors.greenAccent[700],
          ),
          body: SafeArea(
            child: Container(
              width: 115,
              height: 145,
              margin: EdgeInsets.fromLTRB(80, 20, 20, 20),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF959595)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFFB2FFA6),
              ),
              alignment: Alignment.topCenter,
              child: Text(
                'Completed Activities\n\n' + _done1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}