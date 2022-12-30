import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:van_lines/services/Auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return StreamProvider<UserFB?>.value(
        value: Auth_service().Userx,
        initialData: null,
        child: MaterialApp(
          home: wrapper(),
                  )
    );
  }
}
