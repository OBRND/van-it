import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/home.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  bool isEmailVerified = false;
  bool canResend = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();

    // user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
    //reload user since the status can change before we do the set state
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResend = false);
      await Future.delayed(Duration(seconds: 10));
      setState(()=> canResend = true);
    } catch (e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context)  =>isEmailVerified ?
      Home(): Scaffold(
    appBar: AppBar(
      title: Text('Verify Email'),),
    body: Column(
      children: [
        Text('A verification email has been sent to this email address',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,),
        SizedBox(height: 25,),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
          ),
            icon: Icon(Icons.email, size: 32,),
            onPressed: canResend ? sendVerificationEmail :null,
          label: Text('Resend Email', style: TextStyle(fontSize: 25),),
        ),
        TextButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),),
            onPressed: () => FirebaseAuth.instance.signOut() ,
            child:Text('Cancel')),

      ],
    ),

  );
  }

