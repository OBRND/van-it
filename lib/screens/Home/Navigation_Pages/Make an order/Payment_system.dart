import 'dart:async';

import 'package:flutter/material.dart';
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Finish up with your payment',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: Color(0xff4A5280),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 80),
                  Card(
                    color: Color(0xff4A5280),
                    child: Container(
                      height: 130,
                      child: ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        backgroundColor: Colors.transparent,
                        collapsedBackgroundColor: Colors.transparent,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Text('Price:',
                                  style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w300),),
                              Text(' ${widget.pay[0]} Br',
                                  style: TextStyle(color: Colors.white, fontSize: 25, ),),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Transport Cost:",
                                  style: TextStyle(color: Colors.grey,
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
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300,
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
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300,
                                      fontSize: 18)),
                           Text(" ${widget.pay[2]}",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18)),
                            ],
                          ),
                          // Text("Loading and unloading service:",style: TextStyle(color: Colors.white,fontSize: 18)),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 15),
                    child: Text('How do you want to pay?',
                      style: TextStyle(fontSize: 20),),),
                  build_vancard(context),
                  build_Wallet(context),
                  build_Manual(context)


                ],
              ),
            ]),
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

        child: Card(color: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),
                Text('Pay from my wallet'),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
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
        child: Card(color: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),
                Text('Pay on Drop off'),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build_vancard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  Van_card(pay: widget.pay[0],
                    order: widget.order,
                    locations: widget.locations,
                    Pickup_date: widget.Pickup_date,)));
        },
        child: Container(
          height: 60,
          child: Card(color: Color(0xff132877),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                build_logo(),
                Text('Use Van it card', style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget build_logo() {
    return Card(
      // height: 25,
      // width: 40,
      color: Color(0xff132877),
      child: Image.asset("Assets/fast-delivery-modified.png",height: 60,width: 50,),
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

