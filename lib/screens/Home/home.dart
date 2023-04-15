import 'package:bottom_sheet_expandable_bar/bottom_sheet_bar_icon.dart';
import 'package:bottom_sheet_expandable_bar/bottom_sheet_expandable_bar.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Deposit/Buy_card.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Company_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Furniture_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Home_details.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Special_move.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Services_form.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Notifications.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/trial.dart';
import 'package:get/get.dart';
import 'package:van_lines/models/localstring.dart';

import '../../models/User.dart';
import '../../services/Database.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class Home extends StatefulWidget {
  final List locale =[
    {'name':'English','locale':Locale('en','Us')},
    {'name':'Amharic','locale':Locale('Am','Et')},
  ];
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
      extendBody: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Welcome Home'.tr),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Notifications_page()));
          }, icon: Icon(Icons.notifications_active))
        ],
       ),
      drawer: const PhysicalModel(child: NavigationDrawerModel(),
      color: Colors.green,
      shadowColor: Colors.green,
      elevation: 20.0,),
      body: SingleChildScrollView(
        child: Container(
          width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
          gradient: LinearGradient(
          colors:[ Color(0xFF3588B6),
            Color(0xFF1173A8)])
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children  : [
          Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            height: 200,
            child: Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_kx6a1byu.json',
            ),),),
              _buildcard(cardtype: 'card 1', color: Color(0xFF090943),cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: 'John Doe', cardexpiration: '01\01\2023'),
            ],
          ),
                    ),
      ),
    );
  }

  Widget _buildcard({required String cardtype,required Color color, required String cardnumber,required String accountholder,required String cardexpiration}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black),),
      // elevation: 0,
      color: Colors.blue[200],
      child: Column(
        children: [
          Stack(
            children:[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height*.15),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Buy_card()));
                    },
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ) ,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text( 'We have got great offers for you.'.tr,
                            style: TextStyle(color: Colors.black,fontSize: 19, fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .37,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Wrap(
                            children: [
                              Text('15 %', style: TextStyle(color: Colors.black54, fontSize: 35, fontWeight: FontWeight.w600),),
                              Text(
                              'off on home moving', style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w600),
                            ),]
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        elevation: 5,
                        color: color,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Buy_card()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: MediaQuery.of(context).size.width * .55,
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildlogo(cardtype),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text('Tap here to buy card now!',style: TextStyle(color: Colors.white, fontSize: 15,fontFamily: 'CourierPrime'),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _builddetail(
                                        label: 'Account Holder',
                                        value: '--'
                                    ),
                                    _builddetail(
                                      label: 'Expiration Date',
                                      value: '--',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*.077,
                left: MediaQuery.of(context).size.width*.79,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(-20 / 360),
                  child: Card(
                    color: Color(0xffff9c1a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                      child: Column(
                        children: [
                          Text('Upto'),
                          Text( '20% off!', style: TextStyle(fontWeight: FontWeight.w800),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            children: [
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
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade400)),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Home_details()));
                        },
                        child: Text('Home Moving'.tr,
                            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700))),
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
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue.shade400)),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Furniture_details()));
                        },
                        child: Text('Furniture Move'.tr,  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.black))),
                  ),
                ),
              ),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Service_form()));
              },
                  child: Row(
                    children: [
                      Icon(Icons.forward,color: Colors.black54,),
                      Text('View more', style: TextStyle(color: Colors.black54),),
                    ],
                  ))
              // StaggeredGridTile.count(
              //   crossAxisCellCount: 1,
              //   mainAxisCellCount: 1,
              //   child: Hero(
              //     tag: 'company'.tr,
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: ElevatedButton(onPressed: (){
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (context) => Company_details()));
              //       },
              //           style: ButtonStyle(
              //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //                   RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(35.0),
              //                     side: BorderSide(color: Colors.white54),)),
              //               backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
              //           child: Text('Company Move'.tr,  style: TextStyle(fontSize: 20, color: Colors.black))),
              //     ),
              //   ),
              // ),
              // StaggeredGridTile.count(
              //   crossAxisCellCount: 1,
              //   mainAxisCellCount: 1,
              //   child: Hero(
              //     tag: 'special',
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: ElevatedButton(
              //           style: ButtonStyle(
              //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //                   RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(35.0),
              //                     side: BorderSide(color: Colors.white54),)),
              //               backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
              //           onPressed: (){
              //             Navigator.of(context).push(MaterialPageRoute(
              //                 builder: (context) => Special_details()));
              //           },
              //           child: Text('Special Move'.tr,  style: TextStyle(fontSize: 20, color: Colors.black))),
              //     ),
              //   ),
              // ),


            ],
          ),
        ],
      ),
    );
  }

  Widget _builddetail({required String label, required String value}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label',style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
        Text('$value',style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),),

      ],
    );

  }

  Widget _buildlogo(String cardtype){
    print(cardtype);
    return Container(
        height: 50,
        child: Image.asset(cardtype == 'card 1' || cardtype == 'card 3' ? "Assets/fast-delivery-modified.png" : "Assets/fast-delivery.png", height: 60,width: 50,));
  }

}

