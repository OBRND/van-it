import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';

class About_us extends StatelessWidget {
  // const About_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

      ),
      home: Scaffold(
          drawer: NavigationDrawer(),
      appBar: AppBar(
      title: Text('About us'),
      backgroundColor: Colors.blue,
      ),
        body: Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.yellow),
          child: FloatingActionButton(
               onPressed: () {},
               child: const Icon(Icons.add),
   ),
 ),),
    );
  }
}
