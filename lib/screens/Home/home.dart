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
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF090943), size: 28),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text('V'.tr,
            style: TextStyle(color: Color(0xFF090943), fontSize: 27,),),
            Text('an it'.tr,
            style: TextStyle(color: Color(0xFF090943), fontSize: 22),),
            Image.asset("Assets/fast-delivery-modified.png",height: 40,width: 40, color: Color(0xFF090943),),
          ],
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Notifications_page()));
          }, icon: Icon(Icons.notifications_active, size: 28,))
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
            begin: Alignment.topCenter,
          colors:[ Color(0xFF2190EF),
            Color(0xFFE1E2E7)])
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children  : [
          Container(
            height: MediaQuery.of(context).size.height * .4,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .1 ),
              child: Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_kx6a1byu.json',
              ),
            ),),
              Container(
                  height: MediaQuery.of(context).size.height * .6,
                  child: _buildcard(cardtype: 'card 1', color: Color(0xFF090943),cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: 'John Doe', cardexpiration: '01\01\2023')),
            ],
          ),
                    ),
      ),
    );
  }

  Widget _buildcard({required String cardtype,required Color color, required String cardnumber,required String accountholder,required String cardexpiration}){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.blueAccent),),
      elevation: 0,
      color: Color(0xffd5eef6).withOpacity(.2),
      child: Column(
        children: [
          Stack(
            children:[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height*.15),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ) ,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text( '\u{1F381} Great offers for you!'.tr,
                          style: TextStyle(color: Colors.black54,fontSize: 22, fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                  ),

                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .37,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Wrap(
                            children: [
                              Text('Buy Van cards', style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w600),),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                'to get big discounts off your orders', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),
                            ),
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
                            width: MediaQuery.of(context).size.width * .56,
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
                top: MediaQuery.of(context).size.height*.085,
                left: MediaQuery.of(context).size.width*.78,
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

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .37,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                          children: [
                            Text('15% off', style: TextStyle(color: Colors.black54, fontSize: 22, fontWeight: FontWeight.w600),),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'on all orders', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),]
                      ),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Hero(
                    tag: 'home',
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_rounded, size: 60, color: Colors.white),
                          Text(
                            'Home'.tr,
                            style: TextStyle(
                              fontSize:15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Moving'.tr,
                            style: TextStyle(
                              fontSize:15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Hero(
                    tag: 'furniture'.tr,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(color: Colors.white70),)),
                            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Furniture_details()));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.chair_outlined, size: 60, color: Colors.white),
                            Text('Furniture'.tr,  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                            Text('Moving'.tr,  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400)),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: MediaQuery.of(context).size.width * .42),
            child: TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Service_form()));
            },
                child: Row(
                  children: [
                    Text('Explore our other services', style: TextStyle(color: Colors.blue),),
                    Icon(Icons.arrow_forward_ios,color: Colors.blueAccent, size: 30,),
                  ],
                )),
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

