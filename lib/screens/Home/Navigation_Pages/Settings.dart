import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:get/get.dart';

class settings extends StatelessWidget {
  // const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerModel(),
      appBar: AppBar(
        title: Text('Settings'.tr),
        backgroundColor: Colors.blue,
      ),

    );
  }
}
