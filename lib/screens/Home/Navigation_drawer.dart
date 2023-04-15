import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/Authentication/Authenticate.dart';
import 'package:van_lines/screens/Authentication/Sign_in.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/About_us.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Services_form.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make_order.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Profile.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Wallet.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Settings.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Contact.dart';
import 'package:van_lines/screens/Home/home.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_lines/shared/Passcode.dart';
import 'package:get/get.dart';
import 'package:van_lines/models/localstring.dart';

import '../../services/Storage.dart';


class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final StreamController<bool> _verificationNotifier = StreamController<
      bool>.broadcast();
  bool isAuthenticated = false;
  // final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

String _Current_password = '';
String _New_password = '';
bool valid_password = false;
late String password;

  String Uid = '';
  String first = '';
  String last = '';
  int i = 0;
  bool dataretrieved = false;
  final _formkey = GlobalKey<FormState>();
  final Auth_service _auth= Auth_service();

  Future geturl() async{
    final user = FirebaseAuth.instance.currentUser!;
    Storage storage = Storage();
    final result = await storage.getdata(user.uid);
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
     return Container(
       color: Colors.white,
      child: Stack(
        children: [
          Drawer(
            width: MediaQuery.of(context).size.width *.75,
            elevation: 0,
            backgroundColor: Colors.black12,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildHeader(context),
                  buildMenuItems(context),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SpeedDial(
                child: Text('Language'),
                animatedIcon: AnimatedIcons.menu_close,
                icon: Icons.language,
                children: [
                  SpeedDialChild(
                    child: const Icon(Icons.language),
                    label: 'Amharic',
                    onTap: () {
                      var locale=const Locale('Am','Et');
                      Get.updateLocale(locale);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.language),
                    label: 'Tigrigna',
                    onTap: () {
                      var locale=const Locale('Tg','Et');
                      Get.updateLocale(locale);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.language),
                    label: 'Oromiffa',
                    onTap: () {
                      var locale=const Locale('Or','Et');
                      Get.updateLocale(locale);
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.language),
                    label: 'English',
                    onTap: () {
                      var locale=const Locale('en','Us');
                      Get.updateLocale(locale);
                    },
                  )
                ],

              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    final uid = user!.uid;
      Future display() async {
      List Profile = await DatabaseService(uid: user.uid).getuserInfo();
      setState(() {
        first = Profile[0];
        last = Profile[1];
      });
    }
    if(i == 0){
      display();
      setState((){i = 1; });}
     return Material(
        color: Colors.blueAccent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Profile(),
            ));
          },
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 40),
                    FutureBuilder(
                      future: geturl(),
                      builder:(context, snapshot) {
                        switch(snapshot.connectionState){
                          case ConnectionState.waiting:
                            return CircleAvatar(
                              radius: 40.0,
                              child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            );
                        // case (ConnectionState.done) :
                          default:  return CircleAvatar(
                            radius: 40.0,
                            backgroundImage: NetworkImage('${snapshot.data}'),
                            backgroundColor: Colors.transparent,);
                        }}
                    ),
                    SizedBox(width: 20),
                    Icon(Icons.edit )
                  ],
                ),
                const SizedBox(height: 10),
                ExpansionTile(
                       title: Text("$first $last",
                           style: const TextStyle(fontSize: 20, color: Colors.black),
                       ),
                       children: [
                         TextButton.icon(onPressed:(){
                           Navigator.of(context).pushReplacement(MaterialPageRoute(
                               builder: (context) => Authenticate()));
                           _auth.sign_out();

                         },
                           icon: const Icon(Icons.door_back_door_outlined, color: Colors.white,),
                           label:  Text('Log Out'.tr, style: TextStyle(color: Colors.white),),
                         )
                       ]
                ),
              ],
            ),
          ),
        )
    );
  }
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(10, 3, 0, 5),
    // color: Colors.black12,
    child: Column(
      children: [
        const SizedBox(height: 10 ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title:  Text('Home'.tr,
              style: TextStyle(fontSize: 17), ),
          onTap: (){
            Navigator.pop(context);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Home(),
            ));
          }
        ),
        ListTile(
          leading: const Icon(Icons.bookmark_border),
          title:  Text('Orders'.tr,
            style: TextStyle(fontSize: 17),),
          onTap: (){
            // to close the navigation drawer before going to the orders page
            Navigator.pop(context);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => Orders(),
            ));

          },
        ),
        ListTile(
          leading: const Icon(Icons.account_balance_wallet_outlined),
          title:  Text('wallet'.tr,
            style: TextStyle(fontSize: 17),),
          onTap: ()async{
            final user = Provider.of<UserFB?>(context, listen: false);
            final uid = user!.uid;
           String password = await DatabaseService(uid: uid).getpassword();
                if(password != null) {
                  print('==========================================================================');
                  return _showLockScreen(
              context,
              opaque: false,
              cancelButton:  Text(
                'Cancel'.tr,
                style: TextStyle(fontSize: 16, color: Colors.white,),
                semanticsLabel: 'Cancel',
              ), digits: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
            );}
              else {
                  Text('Please check your connection'.tr);
                }
              // return Text('Error');

            // Navigator.pop(context);
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (context) => const Wallet(),
            // ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title:  Text('Make an order'.tr,
            style: TextStyle(fontSize: 17),),
          onTap: (){
            Navigator.pop(context);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Service_form(),
            ));
          },
        ),
        const Divider(color: Colors.black38),
        ListTile(
          leading: const Icon(Icons.contact_support),
          title:  Text('Contact us'.tr,
            style: TextStyle(fontSize: 17),),
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Contact_us()
            ));
          }
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title:  Text('About us'.tr,
            style: TextStyle(fontSize: 17),),
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>  About_us(),
            ));
          }
        ),
      ],
    ),
  );

//?
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
                title:  Text(
                  'Enter Passcode'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 28),
                ),
                circleUIConfig: circleUIConfig,
                keyboardUIConfig: keyboardUIConfig,
                passwordEnteredCallback: _passcodeEntered,
                cancelButton: cancelButton,
                deleteButton:  Text(
                  'Delete'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  semanticsLabel: 'Delete',
                ),
                shouldTriggerVerification: _verificationNotifier.stream,
                backgroundColor: Colors.black.withOpacity(0.8),
                cancelCallback: _passcodeCancelled,
                digits: digits,
                passwordDigits: 6,
                bottomWidget: _passcodeRestoreButton(),
              ),
        ));
  }

  // String storedPasscode = '123456';

  _passcodeEntered(String enteredPasscode) async{
    final user = Provider.of<UserFB?>(context,  listen: false);
    final uid = user!.uid;
    password = await DatabaseService(uid: user.uid).getpassword();
    bool isValid = password == enteredPasscode;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Wallet()));
    }
  }

  _passcodeCancelled() {
    Navigator.maybePop(context);
  }

  _passcodeRestoreButton() =>
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: TextButton(
            onPressed: _resetApplicationPassword,
            child:  Text(
              "Reset passcode".tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );

  _resetApplicationPassword() {
    Navigator.maybePop(context).then((result) {
      if (!result) {
        return;
      }
      _restoreDialog(() {
        Navigator.maybePop(context);
      });
    });
  }

  _restoreDialog(VoidCallback onAccepted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal[50],
          title:  Text(
            "Reset passcode".tr,
            style: TextStyle(color: Colors.black87),
          ),
          content:  Text(
            "Passcode reset is a non-secure operation!\nAre you sure want to reset?".tr,
            style: TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child:  Text(
                "Cancel".tr,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
            TextButton(
              child:  Text(
                "I proceed".tr,
                style: TextStyle(fontSize: 18),
              ),
              onPressed: onReset,
            ),
          ],
        );
      },
    );
  }

  onReset(){
    showDialog(
        context: context,
        builder: (BuildContext context)
    {
      String error= '';
      return AlertDialog(
        title: Text('Change Password'.tr),
        content: Container(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                   maxLength: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration:  InputDecoration(
                      labelText: 'Enter the current Passcode'.tr,
                    ),
                  validator: (val) => val!.isEmpty ? 'The current passcode is incorrect': val.length != 6 ?
                  'The passcode can only be six digits long ' : null,
                    onChanged: (val){
                      setState(() => _Current_password = val);
                    }
                ),
                TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration:  InputDecoration(
                      labelText: 'Enter a new Passcode'.tr,
                    ),
                  validator: (val) => val!.isEmpty ? 'The current passcode is incorrect': val.length != 6 ?
                  'The passcode can only be six digits long ' : null,
                    onChanged: (val){
                      setState(() => _New_password = val);
                    }
                ),
              TextButton(onPressed: () async{
                if(_formkey.currentState!.validate()){
                  final user = Provider.of<UserFB?>(context, listen: false);
                  final uid = user!.uid;
                  password = await DatabaseService(uid: user.uid).getpassword();
                  // bool isValid = password == enteredPasscode;
                  if(password == _Current_password) {
                    await DatabaseService(uid: user.uid).changePassword(_New_password);

                  }
                  print('huhuhuhuhuuh on that bs');
                  setState(()=> error = 'Sorry, the password you entered is incorrect, enter the correct password');
                }
                }, child: Text("Confirm".tr)
              ),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              )
              ],
            ),
          )
        ),

      );
    } );
  }

}
