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
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
        drawer: NavigationDrawerModel(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Select categories", style: TextStyle(fontSize: 20, color: Colors.black54),),
        ),
        body: AlignedGridView.count(
          crossAxisCount: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          itemCount: 1,
          itemBuilder: (context, index) {
            return StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              children: [
                StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: .5,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Text('Which service do you require?'.tr,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
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
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: Colors.white54),
                            ),
                          ),
                          backgroundColor:
                          MaterialStateColor.resolveWith((states) => Colors.blueAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home_details()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home_rounded, size: 80, color: Colors.white),
                              Text(
                                'Home Move'.tr,
                                style: TextStyle(
                                  fontSize:18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                                     borderRadius: BorderRadius.circular(50.0),
                                     side: BorderSide(color: Colors.white54),)),
                               backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                           onPressed: (){
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => Furniture_details()));
                       },
                           child: Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(Icons.chair_outlined, size: 80, color: Colors.white),
                                 Text('Furniture Move'.tr,  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400)),
                               ],
                             ),
                           )),
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
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.white54),)),
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.business_rounded, size: 80, color: Colors.white, weight: 2 ),
                                Text('Company Move'.tr,  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          )),
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
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.white54),)),
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                          onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Special_details()));
                      },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning_amber_rounded, size: 80, color: Colors.white),
                                Text('Special Move'.tr,  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),


                ],
              );
          },
        )
    );
  }
}
