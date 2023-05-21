import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders.dart';
import 'package:van_lines/screens/Home/home.dart';
import '../../../../../../models/User.dart';
import '../../../../../../services/Database.dart';
import '../../../../../../shared/Payment_item.dart';

class Pay_wallet extends StatefulWidget {
  final pay;
  final order;
  final Pickup_date;
  final Locations locations;
  Pay_wallet({required this.pay, required this.order, required this.locations,required this.Pickup_date});

  @override
  State<Pay_wallet> createState() => _Pay_walletState(pay,order, locations,Pickup_date);
}

class _Pay_walletState extends State<Pay_wallet> {
  // const Pay_card({Key? key}) : super(key: key);
  Payment_item order;
  DateTime Pickup_date;
  Locations locations;

  _Pay_walletState(this.pay, this.order, this.locations, this.Pickup_date);

  final StreamController<bool> _verificationNotifier = StreamController<
      bool>.broadcast();


  bool isAuthenticated = false;
  int pay;
  bool checked = false;

  Future getbal() async{
    final user = Provider.of<UserFB?>(context);
    List account = await DatabaseService(uid: user!.uid).getaccount();
    return account;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff4A5280),
        appBar: AppBar(
          backgroundColor: Color(0xff4A5280),
          elevation: 0,
        ),
        body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  color: Color(0xff4A5280),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: Column(
                  children: [
                    build_details(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .7,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black),),
                      // elevation: 0,
                      child: Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 10, 15),
                              child: Text.rich(TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: 'An amount of ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),),
                                TextSpan(
                                    text: "$pay Br.",
                                    style: TextStyle(color: Colors.red,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' will be deducted from your wallet.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
                              ]
                                // ,style: TextStyle(fontSize: 20),),)
                              ),
                              ),
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height * .5,
                            child: build_terms(),),
                            ElevatedButton(onPressed: !checked ? (){
                              const snackBar = SnackBar(
                                content: Text('Agree to the terms of service'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            } : () async {
                              final user = Provider.of<UserFB?>(
                                  context, listen: false);
                              final uid = user!.uid;
                              print('${[ order, locations, Pickup_date, pay ]}');
                              await DatabaseService(uid: user.uid).orders(
                                  order, locations, Pickup_date, pay, 'Paid');
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Orders()));
                            },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                                child: Text('Complete Payment', style: TextStyle(fontSize: 17),),
                              ),
                              style: !checked ? ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.white38
                              ) : ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                              )
                              // color: Colors.blueGrey,
                            )
                          ]
                      ),
                    ),
                  ),
                ),
              )
            ]
        )
    );
  }

  Widget build_terms() {
    return Card(
      elevation: 0,
      color: Colors.white70,
      child: ExpandablePanel(
        theme: ExpandableThemeData(iconColor: Colors.blueAccent ),
        header: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text('Read this before you pay!', style: TextStyle(
              color: Colors.red, fontSize: 16, fontWeight: FontWeight.w700),),
        ),
        collapsed: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.red,
                  onChanged: (bool? value) {
                    setState(() => checked = !checked);
                  },
                  value: checked,
                ),
                Text('I have read and agree to the Terms')
              ],
            ),

          ],
        ),
        expanded: Card(
          elevation: 0,
          color: Colors.transparent,
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  '1. Any change in Order or cancelation of the order should be done prior to the start of delivery delivery.\n '
                      ' - There will be penalities for any cancelations after the start of the order\n'
                      ' - We are not responsible for any misunderstanding after this set time\n'
                      ' - In the event of such changes after the order a calculated price will be deducted from your van it account\n',
                  style: TextStyle(fontSize: 15), textAlign: TextAlign.start,),
                SizedBox(height: 10,),
                Text('Finish your order by agreeing to these terms',
                  style: TextStyle(color: Colors.red, fontSize: 15),)
              ],
            ),
          ),
        ),
        builder: (_, collapsed, expanded) =>
            Expandable(
              collapsed: collapsed,
              expanded: expanded,
            ),
      ),
    );
  }

  Widget build_details() {
    return FutureBuilder(
        future: getbal(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
          String formatted = NumberFormat('#,##0.00', 'en_US').format(double.parse(snapshot.data[1].toString()));
        print('future returned: ${snapshot.data}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black38,
                ));
          default:
            return Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Card(
                  color: Color(0xff4A5280),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Balance", style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                              Text('${formatted} Br',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                      ]
                  )
              ),
            );
        }
        }
    );
  }

  String formatDouble(double number) {
    String formattedNumber = number.toStringAsFixed(2);
    int indexOfDecimalPoint = formattedNumber.indexOf('.');
    if (indexOfDecimalPoint != -1) {
      String beforeDecimalPoint = formattedNumber.substring(0, indexOfDecimalPoint);
      String afterDecimalPoint = formattedNumber.substring(indexOfDecimalPoint + 1);
      formattedNumber = '$beforeDecimalPoint,${afterDecimalPoint.substring(1)}';
    }
    return formattedNumber;
  }
}