import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Wallet.dart';

import '../../../../models/User.dart';
import '../../../../services/Database.dart';
import 'package:get/get.dart';

class Card_form extends StatefulWidget {
  String fullname;
  List card_info;
  Card_form(this.fullname, this.card_info);

  @override
  State<Card_form> createState() => _Card_formState(fullname, card_info);
}

class _Card_formState extends State<Card_form> {
  final String fullname;
  final List card_info;
  _Card_formState( this.fullname, this.card_info);

  String Code = '' ;
  int cardamount = 0;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    // DatabaseService databaseservice = DatabaseService(uid: user!.uid);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          title: Text('Choose a payment method'.tr,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.indigo,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),)
      ),
      body: Stack(
          children:[
            Container(
                height: 100,
                decoration:BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),)),
            buildlogos()
    ],
    )
    );
  }

  Widget buildlogos(){
    final user = Provider.of<UserFB?>(context);

    return Container(

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(35,15,25,20),
            child: Text('Through which bank and their service do you like to complete the payment.'.tr,
                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400)),
          ),
          SizedBox(height:40),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
              childAspectRatio: 2,

              children: [
                InkWell(
                onTap: ()async{
                 await _setcode();
                  showAlertDialog(1, user!.uid);
                },
                child: Image.asset("Assets/img_6.png",height: 100,width: 70,),
              ),
                InkWell(
                  onTap: ()async{
                    await _setcode();
                    showAlertDialog(1, user!.uid);
                  },
                  child: Image.asset("Assets/img_3.png",height: 100,width: 70,),
                ), InkWell(
                  onTap: ()async{
                    await _setcode();
                    showAlertDialog(1, user!.uid);
                  },
                  child: Image.asset("Assets/img_4.png",height: 100,width: 70,),
                ), InkWell(
                  onTap: ()async{
                   await _setcode();
                    showAlertDialog(1, user!.uid);
                  },
                  child: Image.asset("Assets/img_5.png",height: 100,width: 70,),
                ), InkWell(
                  onTap: () async{
                    await _setcode();
                    showAlertDialog(1, user!.uid);
                  },
                  child: Image.asset("Assets/img_7.png",height: 100,width: 70,),
                ), InkWell(
                  onTap: () async{
                 await _setcode();
                    showAlertDialog(1, user!.uid);
                  },
                  child: Image.asset("Assets/img_8.png",height: 100,width: 70,),
                ),
              ],
          ),
        ],
      ),
    );
  }
 _setcode() async{
   String r = await generateRandomString(6);
   var y = DateTime.now().day;
   setState(() => Code = '$r$y' );
 }
  showAlertDialog(int choice, uid) {

    Widget CommitedButton = TextButton(onPressed: ()async{
      DatabaseService databaseservice = DatabaseService(uid: uid);
      await databaseservice.Deposit_Requests(fullname, 0 , DateTime.now(), Code, card_info);
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
          " We are not responsible for any inconviniences if the instructions are incorrectly followed**".tr,
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
              text: card_info[0] == 'card 1'? " 8,500 Br.":  card_info[0] == 'card 2' ? ' 16,000 Br.' :card_info[0] == 'card 3' ? ' 24,000 Br.'
                  :card_info[0] == 'card 4' ? ' 40,000 Br.': card_info[0] == 'card 5' ? ' 80,000 Br.': 'Incorrect amount chosen' ,
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
              text: " use this as Reason.\n ",
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
            CommitedButton,
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
  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }


}
