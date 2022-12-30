import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';

class settings extends StatelessWidget {
  // const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue,
      ),

    );
  }
}
