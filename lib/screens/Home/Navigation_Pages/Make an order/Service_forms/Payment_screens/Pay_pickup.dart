import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Wallet.dart';

import '../../../../../../models/User.dart';
import '../../../../../../services/Database.dart';
import '../../../../../../shared/Payment_item.dart';
class Pay_pickup extends StatefulWidget {
  final pay;
  final order;
  final locations;
  final Pickup_date;
  Pay_pickup({required this.pay, required this.order, required this.locations, required this.Pickup_date});

  @override
  State<Pay_pickup> createState() => _Pay_pickupState(pay: pay,order: order, locations: locations, Pickup_date: Pickup_date,);
}

class _Pay_pickupState extends State<Pay_pickup> {
  _Pay_pickupState({required this.pay, required this.order, required this.locations,required this.Pickup_date});
  int pay;
  DateTime Pickup_date;
  Locations locations;
  Payment_item order;

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        title: Text('Manual Pick-up'),
      backgroundColor: Color(0xff4A5280),),
      body: SingleChildScrollView(
          child: Stack(
            children:[
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xff4A5280),
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 45),
                    child: build_terms(),),
                  ElevatedButton(
                    // color: Color(0xff0b194b),
                    onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Wallet()));
                  },
                    child: Text('Go to wallet to deposit', style: TextStyle(color: Colors.white),),),
                  ElevatedButton(onPressed: checked ? null : () async{
                    final user = Provider.of<UserFB?>(context, listen: false);
                    final uid = user!.uid;
                    await DatabaseService(uid: user.uid).orders(order, locations, Pickup_date, pay, 'Unpaid');
                  },
                  child: Text('Finish', style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),)

                ],
              ),]
          )),
    );
  }

  Widget build_terms(){
    return Card(
      color: Colors.white70,
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text('Agree to the terms to continue!',
            style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.bold),),
        ),
        collapsed: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.red,
                  onChanged: (bool? value) {
                    setState(() => checked = !checked);},
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
                const Text('1. You must have amount of at least 1000 br. deposited in your Van wallet to request an order.'
                    '- this amount will be reduced up on payment\n'
                    '2. You must Pay the required Amount in full upon pickup.\n'
                    '3. All payments should be done on time as agreed upon.\n'
                    '4. Any change in Order or cancelation of the order should be done 4 hours prior to delivery.\n '
                    ' - We are not responsible for any misunderstanding after this set time\n'
                    ' - In the event of such changes after the order a calculated price will be deducted from your van it account\n'
                    '5. Should there be any failure in payment.\n'
                    ' - Items to be delivered will be transported to our stores until further notice\n'
                    ' - There will be an automatic freezing of the account and all the assets. \n'
                    ' - Any amount remaining in the wallet will be frozen until further notice.\n'
                    ' - An extended payment window will be provided, this will be the final extended date to be provided.\n'
                    ' 6. If the above agreement is not honered Van-it team will be forced to persue any legal action that would be deemed necessary',
                  style: TextStyle(fontSize: 16),textAlign: TextAlign.start, ),
                SizedBox(height: 10,),
                Text('Finish your order by agreeing to these terms', style: TextStyle(color: Colors.red,fontSize: 20),)
              ],
            ),
          ),
        ),
        builder: (_, collapsed, expanded) => Expandable(
          collapsed: collapsed,
          expanded: expanded,
        ),
      ),
    );
  }
}
