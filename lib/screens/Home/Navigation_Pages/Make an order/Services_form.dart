import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Company_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Furniture_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Special_move.dart';

import '../../Navigation_drawer.dart';
import 'Service_forms/Home_details.dart';
import 'package:get/get.dart';

class Service_form extends StatefulWidget {
  const Service_form({Key? key}) : super(key: key);

  @override
  State<Service_form> createState() => _Service_formState();
}

class _Service_formState extends State<Service_form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        drawer: NavigationDrawerModel(),
        appBar: AppBar(
           backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF1173A8),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          children: [
            StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(45, 80,20, 0),
              child: Text('Which service do you require?'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),),
            )),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Hero(
                tag: 'home',
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                side: BorderSide(color: Colors.white54),)),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                      onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Home_details()));
                  },
                   child: Text('Home Moving'.tr,
                       style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
               child: Hero(
                 tag: 'furniture'.tr,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: ElevatedButton(
                       style: ButtonStyle(
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(35.0),
                                 side: BorderSide(color: Colors.white54),)),
                           backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                       onPressed: (){
                     Navigator.of(context).push(MaterialPageRoute(
                         builder: (context) => Furniture_details()));
                   },
                       child: Text('Furniture Move'.tr,  style: TextStyle(fontSize: 20, color: Colors.black))),
                 ),
               ),
             ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Hero(
                tag: 'company'.tr,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Company_details()));
                  },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                side: BorderSide(color: Colors.white54),)),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                      child: Text('Company Move'.tr,  style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Hero(
                tag: 'special',
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                side: BorderSide(color: Colors.white54),)),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                      onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Special_details()));
                  },
                      child: Text('Special Move'.tr,  style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
              ),
            ),


            ],
          ),

        )
    );
  }
}
