import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tween_wellness/pages/home.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  /* // function for facebook login
  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    // check the status of our login
    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );
    }
  }

  // logout

  logout() async {
    await FacebookAuth.i.logOut();
  }
} */
}
