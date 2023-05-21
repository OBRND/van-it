import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Payment_screens/Pay_wallet.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Payment_screens/Pay_pickup.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Payment_screens/Van_card.dart';
import 'package:van_lines/shared/Payment_item.dart';

import '../../../../models/User.dart';
import '../../../../services/Database.dart';


class Payment_system extends StatefulWidget {
  final List pay;
  final Payment_item order;
  final Locations locations;
  final Pickup_date;

  Payment_system(
      {required this.pay, required this.order, required this.locations, required this.Pickup_date});

  @override
  State<Payment_system> createState() => _Payment_systemState();
}

class _Payment_systemState extends State<Payment_system> {
  final StreamController<bool> _verificationNotifier = StreamController<
      bool>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _verificationNotifier.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4e5e7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Payment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: paymentdetails(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 0, 20),
                child: Text('Choose a payment method',
                  style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.w400),),),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(
                        colors:[ Color(0xff060f42),
                          Color(0xff424242)
                        ])
                ),
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.black),),
                    // elevation: 0,
                    child: build_vancard(context)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                build_Wallet(context),
                build_Manual(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentdetails(){
    return  Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey),),
      color: Color(0xff060f42),
      child: ExpansionTile(
        collapsedIconColor: Colors.blueAccent,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            Row(
              children: [
                Icon(Icons.playlist_add_outlined,color:  Colors.white70, size: 35,),
                Text('Total Price:',
                  style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w700),),
                Text(' ${widget.pay[0]} Br',
                  style: TextStyle(color: Colors.white, fontSize: 20, ),),
              ],
            ),
          ],
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Transport Cost:",
                  style: TextStyle(color: Colors.white70,
                      fontSize: 18, fontWeight: FontWeight.w300)),
              Text(" ${widget.pay[1]} ",
                  style: TextStyle(color: Colors.white,
                      fontSize: 18)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Packaging Cost:',
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300,
                      fontSize: 18)),
              Text(' ${widget.pay[3]}',
                  style: TextStyle(color: Colors.white,
                      fontSize: 18)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Service with tax:",
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w300,
                      fontSize: 18)),
              Text(" ${widget.pay[2]}",
                  style: TextStyle(color: Colors.white,
                      fontSize: 18)),
            ],
          ),
          // Text("Loading and unloading service:",style: TextStyle(color: Colors.white,fontSize: 18)),
          SizedBox(height: 20,)

        ],
      ),
    );

  }

  Widget build_Wallet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          return _showLockScreen(context,
            opaque: false,
            cancelButton: const Text(
              'Cancel', style: TextStyle(fontSize: 16, color: Colors.white,),
              semanticsLabel: 'Cancel',),
            digits: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],);
        },

        child: buildbutton(2),
      ),
    );
  }

  Widget build_Manual(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Pay_pickup(pay: widget.pay,
                    order: widget.order,
                    locations: widget.locations,
                    Pickup_date: widget.Pickup_date,)));
        },
        child: buildbutton(1),
      ),
    );
  }

  Widget buildbutton(index){
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.height * .15,
            width: MediaQuery.of(context).size.width * .38,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FaIcon(index == 1 ? FontAwesomeIcons.moneyCheckDollar: FontAwesomeIcons.wallet,
                        size: 30, color: Colors.grey[800],),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(index == 1 ? 'Pay on Drop off': 'Pay from Wallet',
                     style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),),
                    SizedBox(width: 5,),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
          )

        ],
      ),
    );
  }

  Widget build_vancard(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    Van_card(pay: widget.pay[0],
                      order: widget.order,
                      locations: widget.locations,
                      Pickup_date: widget.Pickup_date,)));
          },
          child:  Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .6,
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    build_logo(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('XXXXX XXXXX',style: TextStyle(color: Colors.white, fontSize: 21,fontFamily: 'CourierPrime'),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pay with van card', style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'CourierPrime'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_forward_ios,  color: Colors.blueAccent),
        )
      ],
    );
  }

  Widget build_logo() {
    return Card(
      elevation: 0,
      // height: 25,
      // width: 40,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Image.asset("Assets/fast-delivery-modified.png",height: 80,width: 80,),
      ),
    );
  }

  _showLockScreen(BuildContext context,
      {required bool opaque,
        CircleUIConfig? circleUIConfig,
        KeyboardUIConfig? keyboardUIConfig,
        required Widget cancelButton,
        List<String>? digits}) {
    Navigator.push(
        context,
        PageRouteBuilder(
          opaque: opaque,
          pageBuilder: (context, animation, secondaryAnimation) =>
              PasscodeScreen(
                title: const Text(
                  'Enter Passcode',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 28),
                ),
                circleUIConfig: circleUIConfig,
                keyboardUIConfig: keyboardUIConfig,
                passwordEnteredCallback: _passcodeEntered,
                cancelButton: cancelButton,
                deleteButton: const Text(
                  'Clear',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  semanticsLabel: 'Clear',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: Colors.black.withOpacity(0.8),
                cancelCallback: _passcodeCancelled,
                digits: digits,
                passwordDigits: 6,
                bottomWidget: null,
              ),
        ));
  }

  // BuildContext context ;
  _passcodeEntered(String enteredPasscode) async {
    final user = Provider.of<UserFB?>(context, listen: false);
    final uid = user!.uid;
    String password = await DatabaseService(uid: user.uid).getpassword();
    bool isValid = password == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              Pay_wallet(pay: widget.pay[0],
                order: widget.order,
                locations: widget.locations,
                Pickup_date: widget.Pickup_date,)));
    }
  }

  _passcodeCancelled() {
    Navigator.maybePop(context);
  }
}

