import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tween_wellness/pages/home.dart';

void main() async {
  //FirebaseFirestore.instance.settings;
  //timestampsInSnapshotsEnabled: true
  // .then((_) {
  //  print("Timestamps enabled in snapshots\n");
  //}, onError: (_) {
  //  print("Error enabling timestamps in snapshots\n");
  //});
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '18TWEEN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
      ),
      home: Home(),
    );
  }
}
