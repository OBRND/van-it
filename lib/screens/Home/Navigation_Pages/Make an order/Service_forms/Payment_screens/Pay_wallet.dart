import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
        appBar: AppBar(
          backgroundColor: Color(0xff4A5280),
          title: Text('Your wallet',
            style: TextStyle(color: Colors.white, fontSize: 25),),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Stack(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff4A5280),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                    ),
                  ),
                  Column(
                      children: [
                        SizedBox(height: 10),
                        build_details(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 25, 10, 15),
                          child: Text.rich(TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: 'An amount of ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300),),
                            TextSpan(
                                text: "$pay Br.",
                                style: TextStyle(color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: ' will be deducted from your wallet.',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300)),
                          ]
                            // ,style: TextStyle(fontSize: 20),),)
                          ),
                          ),
                        ),
                        build_terms(),
                        SizedBox(height: 20,),
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
                          child: Text('Pay', style: TextStyle(fontSize: 17),),
                          style: !checked ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.white38
                          ) : ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          )
                          // color: Colors.blueGrey,
                        )
                      ]
                  )
                ]
            )
        )
    );
  }

  Widget build_terms() {
    return Card(
      color: Colors.white70,
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text('Read this before you pay!', style: TextStyle(
              color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
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
                  style: TextStyle(color: Colors.red, fontSize: 18),)
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
        print('future returned: ${snapshot.data}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black38,
                ));
          default:
            return Card(
                color: Color(0xff4A5280),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Account holder: ${snapshot.data[0]}", style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w100)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Your credits: ${snapshot.data[1]}", style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w100)),
                      ),
                    ]
                )
            );
        }
        }
    );
  }
}