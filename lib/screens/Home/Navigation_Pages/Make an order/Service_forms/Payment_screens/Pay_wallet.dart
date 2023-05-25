import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  int bal = 0;

  Future getbal() async{
    final user = Provider.of<UserFB?>(context);
    List account = await DatabaseService(uid: user!.uid).getaccount();
    bal = account[1];
    return account;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF090943),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  color: Colors.transparent,
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
                              padding: const EdgeInsets.fromLTRB(30, 25, 30, 15),
                              child: Text.rich(TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: 'An amount of ',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),),
                                TextSpan(
                                    text: "$pay Br",
                                    style: TextStyle(color: Colors.redAccent,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' will be deducted from your balance.',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400)),
                              ]
                                // ,style: TextStyle(fontSize: 20),),)
                              ),
                              ),
                            ),

                            StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return Column(
                                    children: [
                                      SizedBox(height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * .5,
                                        child: Card(
                                          elevation: 0,
                                          color: Colors.white70,
                                          child: ExpandablePanel(
                                            theme: ExpandableThemeData(iconColor: Colors.blueAccent ),
                                            header: Padding(
                                              padding: const EdgeInsets.all(18.0),
                                              child: Text('Read this before you pay!', style: TextStyle(
                                                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.w900),),
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
                                                      ' - Any change in Order or cancelation of the order should be done prior to the start of delivery delivery.\n '
                                                          ' - There will be penalities for any cancelations after the start of the order.\n'
                                                          ' - We are not responsible for any misunderstanding after this set time.\n'
                                                          ' - In the event of such changes after the order a calculated price will be deducted from your van it account.\n',
                                                      style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,),
                                                    SizedBox(height: 10,),
                                                    Text('Finish your order by agreeing to these terms',
                                                      style: TextStyle(color: Colors.blueAccent, fontSize: 15),)
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
                                        ),),
                                      ElevatedButton(onPressed: !checked ? () {
                                        const snackBar = SnackBar(
                                          content: Text(
                                              'Agree to the terms of service'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } : () async {
                                        makealert();
                                        final user = Provider.of<UserFB?>(
                                            context, listen: false);
                                        final uid = user!.uid;
                                        print('${[ order, locations, Pickup_date, pay ]}');
                                        await DatabaseService(uid: user.uid).orders(
                                            order, locations, Pickup_date, pay, 'Paid');
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) => Orders()));
                                      },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                50, 10, 50, 10),
                                            child: Text('Complete Payment',
                                              style: TextStyle(fontSize: 17),),
                                          ),
                                          style: !checked ? ElevatedButton
                                              .styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)),
                                              backgroundColor: Colors.white38
                                          ) : ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(20)),

                                          )
                                        // color: Colors.blueGrey,
                                      )
                                    ],
                                  );
                                }
                            ),

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

  Widget build_details() {
    return FutureBuilder(
        future: getbal(),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        print('future returned: ${snapshot.data}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black38,
                ));
          default:
            String formatted = NumberFormat('#,##0.00', 'en_US').format(double.parse(snapshot.data[1].toString()));
            return Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Card(
                elevation: 0,
                  color: Colors.transparent,
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

  makealert() {
    return AnimatedSnackBar(
      builder: ((context) {
        String formatted = NumberFormat('#,##0.00', 'en_US').format(double.parse((bal - pay).toString()));
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          elevation: 0,
          color: Colors.black54.withOpacity(.8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.8),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.check,
                      size: 30, color: Colors.green,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Order successful', style:  TextStyle(color: Colors.green.withOpacity(.5), fontSize: 18, fontWeight: FontWeight.w600),),
                      Text('Your new balance is:', style:  TextStyle(color: Colors.white70.withOpacity(.5), fontSize: 14, fontWeight: FontWeight.w400)),
                      Text('${formatted} Br', style:  TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ).show(context);
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