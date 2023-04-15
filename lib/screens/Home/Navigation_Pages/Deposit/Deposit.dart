import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Wallet.dart';
import 'dart:math';

import '../../../../models/User.dart';
import '../../../../services/Database.dart';
import 'package:get/get.dart';
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
        title: Text('Deposit to your wallet'.tr),
      ),
      body: Stack(
        children:[
          Container(
          height: 100,
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

  showscreenDialog(BuildContext context, int choice){
   showDialog(context: context,
      builder: (_)=> AlertDialog(
        contentPadding: EdgeInsets.all(10),
        scrollable: true,
        title: Text('We need your legal name for verification purposes'.tr),
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
              showAlertDialog(context, choice);

            }
          }, child: Text('Submit'.tr))
        ],
      ));

  }

    Widget buildcoverphotos(){
    return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,20,25,20),
                child: Text('Through which bank and their service do you like to complete the payment.'.tr,
                    style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400)),
              ),
              SizedBox(height:10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,

                children: [
                  InkWell(
                    onTap: (){
                      showscreenDialog(context, 1);
                    },
                    child: Image.asset("Assets/img_6.png",height: 100,width: 70,),
                  ),
                  InkWell(
                    onTap: (){
                      showscreenDialog(context,2);
                    },
                    child: Image.asset("Assets/img_3.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context,3);
                    },
                    child: Image.asset("Assets/img_4.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context,4);

                    },
                    child: Image.asset("Assets/img_5.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context,5);

                    },
                    child: Image.asset("Assets/img_7.png",height: 100,width: 70,),
                  ), InkWell(
                    onTap: (){
                      showscreenDialog(context,6);

                    },
                    child: Image.asset("Assets/img_8.png",height: 100,width: 70,),
                  ),
                ],
              ),
            ],
          ),
        );


    }

  showAlertDialog(BuildContext context, int choice) {
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
      child: Text("Finish".tr),
      // backgroundColor: Colors.black,
    );    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconveniences if the instructions are incorrectly followed**".tr,
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
            "2) Deposit/transfer".tr,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account ".tr,
            ),
            TextSpan(
              text: " 1000552626265.\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is".tr),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ".tr,
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ".tr,
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
    AlertDialog alert1 = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconveniences if the instructions are incorrectly followed**".tr,
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
        text: "1. choose method of payment, it can be by using tele birr mobile app or using USSD.\n"
            " 2.Deposit/ transfer".tr,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account".tr,
            ),
            TextSpan(
              text: "vanline. phone number 0989765634\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is".tr),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ".tr,
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ".tr,
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
    AlertDialog alert2 = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconveniences if the instructions are incorrectly followed**".tr,
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
        text: "1) choose method of payment, it can be by using Awash branches, amole mobile app or using USSD *996#.\n"
            "2) Deposit/transfer".tr,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account ".tr,
            ),
            TextSpan(
              text: " vanline and Account number 51372620011\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is".tr),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ".tr,
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ".tr,
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
    AlertDialog alert3 = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconveniences if the instructions are incorrectly followed**".tr,
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
        text: "1)  choose method of payment, it can be by using bank of Abyssinia mobile app or using USSD *815#\n"
            "2) Deposit/transfer".tr,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account ".tr,
            ),
            TextSpan(
              text: " vanline and Account number 117299877.\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is".tr),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ".tr,
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ".tr,
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
    AlertDialog alert4 = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconveniences if the instructions are incorrectly followed**".tr,
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
        text: "1)choose method of payment, it can be by using Awash bank mobile banking app or using USSD *901#.\n"
            "2) Deposit/transfer".tr,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account ".tr,
            ),
            TextSpan(
              text: " vanline and Account number 117299877.\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is".tr),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ".tr,
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ".tr,
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
    AlertDialog alert5 = AlertDialog(
      scrollable: true,
      backgroundColor: Colors.white70,
      title: Text("**Follow all the instructions below."
          " We are not responsible for any inconveniences if the instructions are incorrectly followed**".tr,
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
        text: "1)  choose method of payment, it can be by using Awash bank mobile banking app or using USSD *881#.\n"
            "2) Deposit/transfer".tr,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
            TextSpan(
        text: " $amount br",
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
            TextSpan(
              text: " to account ".tr,
            ),
            TextSpan(
              text: " vanline and Account number 117299877.\n",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
            TextSpan(
        text: "3) On the deposit form use the code below as a **Reason** this is very important.\n"
            "4) Your Account will be updated to the deposited amount within the next 12 hours.\n"
            "5) The code is".tr),
            TextSpan(
        text: " $Code ",
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
            TextSpan(
        text: " use this as Reason.\n ".tr,
        ),
            TextSpan(
        text: " Beware of Capitalization of the code. ".tr,
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
        return choice == 1 ? alert: choice == 2 ? alert1: choice == 3 ? alert2: choice == 4? alert3 :
        choice == 5? alert4 : alert5;
      },
    );
  }

  Widget buildform(){
    String label1='How much would you like to deposit? *';
    String label2='First name *';
    String label3='Middle name *';
    String label4='Last name *';
    String hint1='1000 - 100,000 br.';
    String hint2='What is your legal First name?';
    String hint3='What is your legal Middle name?';
    String hint4='What is your legal last name?';
   return Column(
      children: [
        TextFormField( decoration:  InputDecoration(
          hintText: hint1.tr,
        labelText: label1.tr,
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
          decoration:  InputDecoration(
          hintText: hint2.tr,
          labelText: label2.tr,
        ),
          validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
            onChanged: (val){ setState(() {
              First_name = '$val';});}
        ),
        TextFormField(
          decoration:  InputDecoration(
          hintText: hint3.tr,
          labelText: label3.tr,
        ),
          validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
            onChanged: (val){ setState(() {
              Middle_name = '$val';});}
        ),
        TextFormField(
          decoration:  InputDecoration(
          hintText: hint4.tr,
          labelText: label4.tr,
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
