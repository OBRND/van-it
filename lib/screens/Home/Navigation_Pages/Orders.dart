import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Services_form.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders_map/Qr_Scanner.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders_map/Track_orders.dart';
import 'package:van_lines/screens/home/Navigation_drawer.dart';

import '../../../models/User.dart';
import '../../../services/Database.dart';
import '../../../shared/Order_model.dart';


class Orders extends StatefulWidget {
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // const Orders({Key? key}) : super(key: key);
bool disabled_button = false;
bool finished = false;
  bool payment = false;
  double Amount = 10000;
  bool Arrived = false;
  bool scanned = false;
  late order_model snap;
  // Future order;

// @override
// void initState() {
//   super.initState();
//   order = getorder();
//   print('ashjdbahsjdbjashbdjahsbdjhsabdjhabsjdasasadasdsadasdsadd');
// }
void dispose() {
  super.dispose();
}

Future getorder() async{
   final user = Provider.of<UserFB?>(context);
  DatabaseService databaseservice = DatabaseService(uid: user!.uid);
  final order_model snapshot = await databaseservice.check_order();
  print(snapshot);
  snap = snapshot;
    return snapshot;
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      drawer: NavigationDrawer(),
      appBar: AppBar(

        elevation: 0,
        title: Text('My Orders'),
        backgroundColor: Color(0xff2c324d),
      ),
      body: FutureBuilder(
        future: getorder(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            // case (ConnectionState.done) :
            default:  return Stack(
                 children: [
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .105,
                        ),
                        Text('       Current Order',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 20)),
                        snap.Order_status == 'Complete' ?
                        _build_finished(context, snap.Payment_status, snap.Payment) :
                        _build_current(snap),
                        SizedBox(height: 15),
                        Text('       Order history',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 20)),
                        SingleChildScrollView(
                          child: _build_history(),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .1,
                  decoration: BoxDecoration(
                    color: Color(0xff2c324d),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 5, 0, 0),
                        child: ElevatedButton(
                          // shape: ShapeBorder.lerp( 5),
                          // color: Color(0xffe33410),
                          onPressed: snap.Order_status == 'pending' || snap.Order_status == 'complete' ? null :
                              snap.Order_status == 'In progress' ?
                              () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Track_orders(),
                                  ));
                                } : null,
                          child: Text(
                            " Track progress ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
          }
          }
      ),

    );
  }

  Widget _build_finished(BuildContext context, String payment_status, int payment){
    return SingleChildScrollView(
      child: Container(
        color: Colors.white38,
        child: Column(
          children: [
            Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.black),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(' Delivery completed ',style: TextStyle( fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Before we conclude please finalize all required parts on this form ',),
                    ),
                    Divider(),
                    Card(
                      child: Column(
                        children: [
                          Text('Payment'),
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.red),
                            child: CheckboxListTile(
                              checkboxShape: CircleBorder(),
                              activeColor: Colors.white70,
                              checkColor: Colors.green,
                              title: Text( payment_status == 'Paid'? 'You have concluded all your Payment': 'You have $payment Br. remaining in payment '),
                              value: payment_status == 'Paid' , onChanged: (value){},
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Divider(),
                          Text('Please check to verify if all packages have arrived'),
                          CheckboxListTile(
                            title: Text('All packages have arrived'),
                            value: Arrived, onChanged: (value){
                              setState(() => Arrived = !Arrived);
                          },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: scanned ? Text('Verified scan' ) :ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Qr_Scanner()));
                                },
                                child: Text('Scan Qr code')),
                            value: scanned,
                            onChanged: (value){

                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ],
                      ),
                    )

                  ],
                )),

          ],
        ),
      ),
    );
  }

  Widget _build_current(order_model order){
    return Card(
        color: Colors.grey,
      child: disabled_button ?
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text('You don\'t have any pending order.\n'
              'To make an order click the button below. ',
              style: TextStyle( fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 19)),
        ElevatedButton(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10)),
         onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => Service_form()));
             }, child: Text('Make an Order',style: TextStyle(color:Colors.white, fontSize: 16),),
        // color: Color(0xff3d437c),
          )],
      ),
    ) :
      ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
          child: Text('Order : ${order.Order_ID}',style: TextStyle(color:Color(0xff2F2929), fontSize: 19, fontWeight: FontWeight.w700),),
        ),
          collapsed:  Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
            child: Text('Status: ${order.Order_status}',style: TextStyle(color:Color(0xff2F2929), fontSize: 19, fontWeight: FontWeight.w700),),
          ),
          expanded: _Order_details()
      )
    );
  }

  Widget _Order_details(){
    int len = snap.Items.toString().length;
    return Column(
       children:[
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Wrap(
             direction: Axis.horizontal,
             alignment: WrapAlignment.spaceEvenly,
             children: [
               Text('Delivery Items: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
               Text({snap.Items}.toString().substring(2, len)),
             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text('Pick up detail: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
               Row(
                 children: [
                   Text('${snap.Floor_pickup} ${check(snap.Floor_pickup)} Floor,'),
                   Text(snap.has_elevator_pickup ? ' with an elevator': 'With no elevator')],
               ),

             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text('Destination detail: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
             Row ( children:[
                 Text('${snap.Floor_destination} ${check(snap.Floor_pickup)} Floor,'),
               Text(snap.has_elevator_destination ? ' with an elevator': 'With no elevator')
             ])

             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text('Payment information: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
               Row(
                 children: [
                   Text('${snap.Payment} Br. '),
                   Text(snap.Payment_status == 'Paid' ? ' All paid': 'not yet paid')],
               ),

             ],
           ),
         ),
       ]
    );

  }
  String check(int num){
  if(num == 1)  return 'ˢᵗ';
  if(num == 2)  return 'ⁿᵈ';
  if(num == 3)  return 'ʳᵈ';
  else return 'ᵗʰ';
  }

  Widget _build_history(){
    return Card(
      child: disabled_button ?
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text('There are no past orders in your history. ',
              style: TextStyle( fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 19)),
        ],
      ),
    ) :
      Column(
        children: [
          Text('Order'),

        ],
      ),
    );
  }
}

