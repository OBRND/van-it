import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Wallet.dart';
import 'dart:math';

import '../../../../models/User.dart';
import '../../../../services/Database.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {

  int amount = 0 ;
  String Code = '' ;
  String Fullname = '';
  String First_name = '';
  String Middle_name = '';
  String Last_name = '';

  final _formkey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
  // final uid = user!.uid;
  DatabaseService databaseservice = DatabaseService(uid: user!.uid);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Text('Deposit to your wallet'),
      ),
      body: Stack(
        children:[
          Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10,10),
          child: buildcoverphotos()),
      ]
      )
    );
  }
   _displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 2000),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Center(
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children:<Widget> [
                  Text('Hai This Is Full Screen Dialog', style: TextStyle(color: Colors.red, fontSize: 20.0),),
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: Text("DISMISS",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  showscreenDialog(BuildContext context){
   showDialog(context: context,
      builder: (_)=> AlertDialog(
        contentPadding: EdgeInsets.all(10),
        scrollable: true,
        title: Text('We need your legal name for verification purposes'),
        content: Form(
            key: _formkey,
            child: buildform()),
        actions: [
          TextButton(onPressed: () async{
            if(_formkey.currentState!.validate()) {
              generateRandomString(6);
              String r = await generateRandomString(6);
              var y = DateTime.now().day;
              setState(() {
                Fullname = '$First_name $Middle_name $Last_name';
                Code = '$r$y';
              } );
              showAlertDialog(context);

            }
          }, child: Text('Submit'))
        ],
      ));

  }

  // Widget _builddepositform() {
  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: ExpandableNotifier( // <-- Provides ExpandableController to its children
  //       child: Column(
  //         children: [
  //           Expandable(
  //             // <-- Driven by ExpandableController from ExpandableNotifier
  //             collapsed: ListView(
  //                 shrinkWrap: true,
  //                   children:[
  //                 buildcoverphotos( 1),
  //                 buildcoverphotos( 2),
  //
  //
  //               ]),
  //             expanded: Column(
  //                 children: [
  //                   Form(
  //                       key: _formkey,
  //                       child: buildform()),
  //                   SizedBox(height:20),
  //                   ExpandableButton( // <-- Collapses when tapped on
  //                     // theme: ExpandableThemeData(collapseIcon: Icons.arrow_back,iconColor: Colors.blue),
  //                     child: Icon(Icons.arrow_back_rounded,size: 30,),
  //                   ),
  //                   ElevatedButton(
  //                       onPressed: () async{
  //                         if(_formkey.currentState!.validate()){
  //                           String r = await generateRandomString(6);
  //                           var y = DateTime.now().day;
  //                           setState(() => Code = '$r$y' );
  //                           showAlertDialog(context);
  //                         }
  //
  //                   },
  //                       child: Text('Next',
  //                         style: TextStyle(fontSize: 20,),))
  //                 ]
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }

    Widget buildcoverphotos(){
    return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,20,25,20),
                child: Text('Through which bank and their service do you like to complete the payment.',
                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,

                children: [
                  InkWell(
                    onTap: (){
                      showscreenDialog(context);
                    },
                    child: Image.asset("Assets/img_6.png",height: 100,width: 70,),
                  ),
                  InkWell(
                    onTap: (){
                      showscreenDialog(context);
                    },
                    child: Image.asset("Assets/img_3.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context);
                    },
                    child: Image.asset("Assets/img_4.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context);

                    },
                    child: Image.asset("Assets/img_5.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context);

                    },
                    child: Image.asset("Assets/img_7.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context);

                    },
                    child: Image.asset("Assets/img_8.png",height: 100,width: 70,),
                  ),
                ],
              ),
            ],
          ),
        );


    }

  showAlertDialog(BuildContext context) {
    final user = Provider.of<UserFB?>(context, listen: false);
    DatabaseService databaseservice = DatabaseService(uid: user!.uid);

    // set up the buttons
    // Widget Depositbutton = FloatingActionButton(onPressed: (){
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context) => Deposit()));
    // },
    //   child: Text("Deposit to wallet"),
    //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) ),
    //   backgroundColor: Colors.indigo,
    // );
    Widget Commited_button = TextButton(onPressed: ()async{
     await databaseservice.Deposit_Requests(Fullname, amount, DateTime.now(), Code, ['No card']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Wallet()));
    },
      child: Text("Finish"),
      // backgroundColor: Colors.black,
    );    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconviniences if the instructions are incorrectly followed**",
          style:TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 15,)
      ),
      content: SelectableText.rich(
        TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          children: <TextSpan>[
        TextSpan(
        text: "1) Choose any method Namely Manual/branch, Mobile banking or CBE birr to deposit/transfer.\n"
            "2) Deposit/transfer",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account ",
            ),
            TextSpan(
              text: " 1000552626265.\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is"),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ",
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ",
              style: TextStyle(color: Colors.red)
        ),
          ],
        ),
      ),

      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Depositbutton,
            // SizedBox(height: 5,),
            Commited_button,
          ],
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildform(){
   return Column(
      children: [
        TextFormField( decoration: const InputDecoration(
        hintText: '1000 - 100,000 br.',
        labelText: 'How much would you like to deposit? *',
        ),
            validator: (val) => val!.isEmpty ? 'Enter a valid Amount to be deposited' : null,
        keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (val){
          // int v = val as int;
          setState(() => amount = int.parse(val));
        }),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: const InputDecoration(
          hintText: 'What is your legal First name?',
          labelText: 'First name *',
        ),
          validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
            onChanged: (val){ setState(() {
              First_name = '$val';});}
        ),
        TextFormField(
          decoration: const InputDecoration(
          hintText: 'What is your legal Middle name?',
          labelText: 'Middle name *',
        ),
          validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
            onChanged: (val){ setState(() {
              Middle_name = '$val';});}
        ),
        TextFormField(
          decoration: const InputDecoration(
          hintText: 'What is your legal last name?',
          labelText: 'Last name *',
        ),
          validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
            onChanged: (val){ setState(() {
              Last_name = '$val';});}
        ),
      ],
    );
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

}
