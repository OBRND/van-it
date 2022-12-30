import 'package:flutter/material.dart';
import 'package:van_lines/screens/Authentication/Sign_in.dart';
import 'package:van_lines/screens/Authentication/Sign_up.dart';

class Authenticate extends StatefulWidget {
  // const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsign_in = true;
  void switchview(){
    setState(() => showsign_in = !showsign_in);
  }
  @override
  Widget build(BuildContext context) {
    if(showsign_in){
      return Sign_in(switchview: switchview);}
    else {
      return Sign_up(switchview: switchview);
    }
  }
}


