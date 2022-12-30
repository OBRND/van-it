import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/trial.dart';

import '../../models/User.dart';
import '../../services/Database.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({Key? key}) : super(key: key);
  // late Object data = {"                  "};
  @override
  Widget build(BuildContext context) {
  //   final user = Provider.of<UserFB?>(context);
  // // Auth_service auth_service =Auth_service();
  // final uid = user!.uid;
  // DatabaseService databaseservice = DatabaseService(uid: user.uid);

    // Future getloc() async{
    //   var dara = await databaseservice.getlocation();
    //   print(dara);
    //   setState((){
    //     data = dara;
    //   });
      // return dara.longitude;
    // }
  // Future setloc() async{
  //     await databaseservice.update_location();
  // }
    // getloc();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Welcome Home'),
       ),
      drawer: PhysicalModel(child: const NavigationDrawer(),
      color: Colors.green,
      shadowColor: Colors.green,
      elevation: 20.0,),
      body: Container(
        width:MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
        gradient: LinearGradient(
        colors:[ Color(0xFF1173A8),
          Color(0xff4d39a1)])
        ),

        child: ElevatedButton(onPressed: (){
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     builder: (context) => DemoPage()));
            }, child: Icon(Icons.refresh))
                  ),

      // bottomSheet: BottomBarSheet(
      //   children: [
      //     BottomSheetBarIcon(
      //       icon: Icon(Icons.home),
      //       color: Colors.redAccent,
      //       onTap: (){
      //       },
      //     ),
      //     BottomSheetBarIcon(
      //       icon: Icon(Icons.person),
      //       color: Colors.blueAccent,
      //       onTap: (){
      //       },
      //     ),
      //     BottomSheetBarIcon(
      //       icon: Icon(Icons.edit),
      //       color: Colors.blue[800],
      //       onTap: (){
      //       },
      //     ),
      //     BottomSheetBarIcon(
      //       icon: Icon(Icons.star),
      //       color: Colors.orangeAccent,
      //       onTap: (){
      //       },
      //     ),
      //   ],
      // ),

    );
  }


}

