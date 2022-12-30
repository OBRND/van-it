import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Deposit/Deposit.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Deposit/Buy_card.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';

import '../../../models/User.dart';
import '../../../services/Database.dart';

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
  int balance= 0;
@override
  Widget build(BuildContext context) {
  final user = Provider.of<UserFB?>(context);
  DatabaseService databaseservice = DatabaseService(uid: user!.uid);

  Future display() async{

      int x = await databaseservice.balance();
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
          drawer: NavigationDrawer(),
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
                                    TextSpan(text: "Your Balance",style:TextStyle(color: Colors.grey,fontSize: 20)),
                                    TextSpan(text: '\n$balance',style:TextStyle(fontSize: 30)),
                                    TextSpan(text: ' Br.',style:TextStyle(color: Colors.grey,fontSize: 20)),
                                    TextSpan(text: '\n\n Your Card',style:TextStyle(color: Colors.grey,fontSize: 15)),
                                  ],),))
                            // ElevatedButton.icon(onPressed: () {}, icon: IconButto, label: label)
                          ]
                      ),
                      // SizedBox(height: 10,),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10,10,10,10),
                        child: Column(
                          children: [
                            _buildcard(cardnumber: "0000 0111 1110 0001 ",
                                accountholder: 'Obrand',
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
                          child: Text('Deposit'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Text(' Latest spendings',style:TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 20,)),
                          ],
                        ),
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
      child: Text("Deposit to wallet"),
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) ),
      backgroundColor: Colors.indigo,
    );
    Widget Buy_cardbutton = FloatingActionButton(onPressed: (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Buy_card()));
    },
      child: Text("Buy card"),
      shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20) ),
      backgroundColor: Colors.deepPurpleAccent,
    );    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white70,
      title: Text("How would you like to Deposit?",
          style:TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,)
      ),
      content: Text("You can choose to deposit to your wallet directly, or buy our van-card for a lesser fee"),
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
  Widget _buildcard({required String cardnumber,required String accountholder,required String amount,required String cardexpiration}){
   return Card(
     elevation: 5,
     color: Color(0xFF090943),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(15)
     ),
     child: Container(
       height: 180,
       width: 260,
       padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           _buildlogo(),
           Padding(
             padding: const EdgeInsets.only(top: 20),
             child: Text('$cardnumber',style: TextStyle(color: Colors.white, fontSize: 21,fontFamily: 'CourierPrime'),),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               _builddetail(
                   label: 'Account Holder',
                 value: accountholder
               ),
               _builddetail(
                 label: 'Expiration Date',
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
    Text('$value',style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold),),

  ],
  );

  }
  Widget _buildlogo(){
  return Row(
    children: [
      Image.asset("Assets/download.png",height: 80,width: 65,),
      // Image.asset("Assets/img1.jpg",height: 25,width: 20,),

    ],
  );
  }

}
