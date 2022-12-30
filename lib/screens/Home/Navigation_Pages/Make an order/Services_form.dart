import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Company_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Furniture_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Special_move.dart';

import '../../Navigation_drawer.dart';
import 'Service_forms/Home_details.dart';

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
        drawer: NavigationDrawer(),
        appBar: AppBar(
           backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors:[ Color(0xFF1173A8),
                    Color(0xff4d39a1)])
          ),
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
              child: Text('which service do you require?',
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
                   child: Text('Home Moving',
                       style: TextStyle(fontSize: 20, color: Colors.black))),
                ),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
               child: Hero(
                 tag: 'furniture',
                 child: TextButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => Furniture_details()));
                 },
                     child: Text('Furniture Move')),
               ),
             ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Hero(
                tag: 'company',
                child: TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Company_details()));
                },
                    child: Text('Company Move')),
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Hero(
                tag: 'special',
                child: TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Special_details()));
                },
                    child: Text('Special Move')),
              ),
            ),


            ],
          ),

        )
    );
  }
}
