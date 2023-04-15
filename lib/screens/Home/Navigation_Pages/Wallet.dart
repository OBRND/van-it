import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Deposit/Deposit.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Deposit/Buy_card.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';

import '../../../models/User.dart';
import '../../../services/Database.dart';
import 'package:get/get.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}
// @override
//  void initState(){
//   Future.delayed(duration)
// }

class _WalletState extends State<Wallet> {
  List balance= [ 0,0];
@override
  Widget build(BuildContext context) {
  final user = Provider.of<UserFB?>(context);
  DatabaseService databaseservice = DatabaseService(uid: user!.uid);

  Future display() async{

      List x = await databaseservice.balance();
      print(x);
        balance = x;
      // setState((){
      //   i= 1;

      // });
      // setState((){
      //   i=1;});
      return x;
  }
     // if(i == 0){
     //   // display();
     //   setState((){
     //     i=1;});
     // }
    return FutureBuilder(
      future: display(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
       if(snapshot.hasData) {
         return Scaffold(
          extendBodyBehindAppBar: true,
          drawer: NavigationDrawerModel(),
          appBar: AppBar(
            title: Text(''),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          body: Stack(
            children: [
              Container(
                height: double.infinity,
              ),
              Container(
                height: MediaQuery.of(context).size.height*.45,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                ),
              ),
              SafeArea(
                child: ListView(
                    children:[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(70,0,30,5),
                                child: RichText(text: TextSpan(
                                  children: [
                                    TextSpan(text: "Your Balance".tr,style:TextStyle(color: Colors.grey,fontSize: 20)),
                                    TextSpan(text: '\n${balance[0]}',style:TextStyle(fontSize: 30)),
                                    TextSpan(text: ' Br.',style:TextStyle(color: Colors.grey,fontSize: 20)),
                                    TextSpan(text: '\n\n Your Card'.tr,style:TextStyle(color: Colors.grey,fontSize: 15)),
                                  ],),))
                            // ElevatedButton.icon(onPressed: () {}, icon: IconButto, label: label)
                          ]
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10,10,10,10),
                        child: balance[1] == 0 && balance[2] == '' ?
                        Card(
                          elevation: 5,
                          color: Color(0xFF090943),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * .75,
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildlogo(),
                                Text('You don\'t have a card yet. We have got excellent offers for you.'.tr, style:TextStyle(color: Colors.grey,fontSize: 15)),
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => Buy_card()));
                                },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.white54),),
                                      backgroundColor: Colors.blue[600]
                                    ),
                                    child: Text('Buy card'.tr))
                              ],
                            ),
                          ),
                        )
                            : Column(
                          children: [
                            _buildcard(balance: "${balance[1]} Br",
                                accountholder: '${balance[2]}',
                                amount: "0",
                                cardexpiration: "10/01/2023")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: (){
                            showAlertDialog(context);

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => Deposit(),));
                          },
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.indigo,
                          child: Text('Deposit'.tr),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: [
                           Text('Latest deposits'.tr, style: TextStyle(color: Colors.blueGrey,
                            fontWeight: FontWeight.bold, fontSize: 20,)),
                          FutureBuilder(
                            future: databaseservice.retrievehistory(),
                              builder: (context,AsyncSnapshot snapshot) {
                                TextStyle style1 =  TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600);
                                TextStyle style2 =  TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.w600);
                                List<Widget> spendings = [];
                              switch(snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.grey
                                      ));
                              // case (ConnectionState.done) :
                                default:
                                  for(int i = 0; i < snapshot.data.length; i++){
                                    spendings.add(Card(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(snapshot.data[i][0] == 0 ?' ' : 'Amount:'.tr, style: style1),
                                              Text(snapshot.data[i][0] ==0 ? '${snapshot.data[i][3]}' :
                                              '${snapshot.data[i][0]} Br'.tr, style: style2,),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Status:'.tr, style: style1,),
                                              Text(snapshot.data[i][2], style: style1.copyWith(
                                                  color:snapshot.data[i][2] == 'Under review'? Colors.orange:
                                                  snapshot.data[i][2] == 'Approved'? Colors.green: Colors.red),),
                                            ],
                                          ),
                                          Text('${DateFormat('yyyy-MM-dd - h:mm a').format(snapshot.data[i][1])}'),
                                        ],
                                      ),
                                    )));
                                  }
                                  return Container(
                                    height: MediaQuery.of(context).size.height * .5,
                                    child: ListView(
                                      children: spendings
                                    ),
                                  );
                              }}
                          ),
                        ],
                      )
                    ]
                ),
              ),
            ],
          )
      );
       }
        else {
        return const Center(
        child: CircularProgressIndicator(),
        );
        }
      },
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget Depositbutton = FloatingActionButton(onPressed: (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Deposit()));
    },
      child: Text("Deposit to wallet".tr),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) ),
      backgroundColor: Colors.indigo,
    );
    Widget Buy_cardbutton = FloatingActionButton(onPressed: (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Buy_card()));
    },
      child: Text("Buy card".tr),
      shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20) ),
      backgroundColor: Colors.deepPurpleAccent,
    );    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white70,
      title: Text("How would you like to Deposit?".tr,
          style:TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,)
      ),
      content: Text("You can choose to deposit to your wallet directly, or buy our van-card for a lesser fee".tr),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Depositbutton,
            SizedBox(height: 5,),
            Buy_cardbutton,
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
  Widget _buildcard({required String balance,required String accountholder,required String amount,required String cardexpiration}){
   return Card(
     elevation: 5,
     color: Color(0xFF090943),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15)
     ),
     child: Container(
       height: 180,
       width: MediaQuery.of(context).size.width * .75,
       padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           _buildlogo(),
           Padding(
             padding: const EdgeInsets.only(top: 10),
             child: Text('$balance',style: TextStyle(color: Colors.white, fontSize: 21,fontFamily: 'CourierPrime'),),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               _builddetail(
                   label: 'Account Holder'.tr,
                 value: accountholder
               ),
               _builddetail(
                 label: 'Expiration Date'.tr,
                 value: cardexpiration,
               ),
             ],
           ),
         ],
       ),
     ),
   );
  }
  Widget _builddetail({required String label, required String value}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('$label',style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),),
    Text('$value',style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),),

  ],
  );

  }
  Widget _buildlogo(){
  return Row(
    children: [
      Image.asset("Assets/fast-delivery-modified.png",height: 80,width: 65,),
      // Image.asset("Assets/img1.jpg",height: 25,width: 20,),

    ],
  );
  }

}
