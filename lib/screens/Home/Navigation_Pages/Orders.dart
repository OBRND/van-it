import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:van_lines/models/history_Model.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Services_form.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders_map/Qr_Scanner.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders_map/Rating.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Orders_map/Track_orders.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'dart:developer';
import '../../../models/User.dart';
import '../../../services/Database.dart';
import '../../../shared/Order_model.dart';
import 'package:get/get.dart';


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
String selectedvalue = '0';

late order_model snap = order_model(Pickupdate:'-', Order_status: '-', Order_ID: '-', Items: ['', '', ''],
      has_elevator_pickup: false, has_elevator_destination: true, Floor_pickup: 1,
      Floor_destination: 4, Payment_status: '-', Payment: 250);
  // Future order;
String userID = '';
@override
void initState() {
  super.initState();
  controller?.dispose();
  // getorder();
}
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
Future gethistory() async{
  final user = Provider.of<UserFB?>(context);
  DatabaseService databaseservice = DatabaseService(uid: user!.uid);
  final List historydata = await databaseservice.gethistory();
  print(historydata);
  return historydata;
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      drawer: NavigationDrawerModel(),
      appBar: AppBar(
        elevation: 0,
        title: Text('My Orders'.tr),
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
                        Text('Current Order'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 20)),
                        snap.Order_status == 'Finished' ?
                        _build_finished(context, snap.Payment_status, snap.Payment) :
                        _build_current(snap),
                        SizedBox(height: 15),
                        Text('Order history'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 20)),
                        Container(
                            height: MediaQuery.of(context).size.height *.45,
                            child: _build_history())
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        // shape: ShapeBorder.lerp( 5),
                        // color: Color(0xffe33410),
                        onPressed: snap.Order_status == '-' || snap.Order_status == 'pending' || snap.Order_status == 'Finished' ? null :
                            () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Track_orders(),
                                ));
                              },
                        child: Text(
                          "Track progress".tr,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: snap.Order_status == 'pending'
                             ? () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white70,
                                title:  Text("Confirm cancellation".tr,
                                    style:TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,)
                                ),
                                content: Text("Confirm if you want to cancel this order".tr),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final user = Provider.of<UserFB?>(context,  listen: false);
                                      await DatabaseService(uid: user!.uid).cancelorder('0');
                                      setState(() {
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Confirm".tr,
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              );;
                            },
                          );
                        } : snap.Order_status == 'On route to Pickup' ? () async {
                              List<DropdownMenuItem<String>> menuItems = [
                                DropdownMenuItem(child: Text("I changed my mind".tr),value: "0"),
                                DropdownMenuItem(child: Text("Driver was late".tr),value: "1"),
                                DropdownMenuItem(child: Text("The order was wrong".tr),value: "2"),
                                DropdownMenuItem(child: Text("Some other reason".tr),value: "3"),
                              ];
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white70,
                                    title:  Text("Confirm cancellation".tr,
                                        style:TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,)
                                    ),
                                    content: StatefulBuilder(
                                        builder:(BuildContext context, StateSetter setState) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Enter a reason for canceling the order".tr),
                                                  DropdownButton(
                                                      iconSize: 25,
                                                      value: selectedvalue,
                                                      onChanged: (
                                                          String? newValue) {
                                                        setState(() =>
                                                        selectedvalue =
                                                        newValue!);
                                                      },
                                                      items: menuItems
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          final user = Provider.of<UserFB?>(context,  listen: false);
                                         await DatabaseService(uid: user!.uid).cancelorder(selectedvalue);
                                         Navigator.pop(context);
                                         setState(() {
                                         });
                                        },
                                        child: Text(
                                          "Confirm".tr,
                                          style: TextStyle(
                                              fontSize: 17, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  );;
                                },
                              );
                              } : null,
                        child: Text(
                          "Cancel order".tr,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
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
                    Text('Delivery completed'.tr,style: TextStyle( fontWeight: FontWeight.w700, color: Colors.black87, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Before we conclude please finalize all required parts on this form'.tr,),
                    ),
                    Divider(),
                    Card(
                      child: Column(
                        children: [
                          Text('Payment'.tr),
                          Theme(
                            data: ThemeData(unselectedWidgetColor: Colors.red),
                            child: CheckboxListTile(
                              checkboxShape: CircleBorder(),
                              activeColor: Colors.white70,
                              checkColor: Colors.green,
                              title: Text( payment_status == 'Paid'.tr? 'You have concluded all your Payment':
                              'You have $payment Br. remaining in payment'.tr),
                              value: payment_status == 'Paid' , onChanged: (value){},
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Divider(),
                          Text('Please check to verify if all packages have arrived'.tr),
                          CheckboxListTile(
                            title: Text('All packages have arrived'.tr),
                            value: Arrived, onChanged: (value){
                              setState(() => Arrived = !Arrived);
                          },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          CheckboxListTile(
                            title: scanned ? Text('Verified scan'.tr ) :ElevatedButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        content: Container(
                                          height: MediaQuery.of(context).size.height *.5,
                                            width: MediaQuery.of(context).size.width,
                                            child: Qr_view(context)),
                                        actions: <Widget>[

                                        ],
                                      );
                                    },
                                  );
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => Qr_Scanner()));

                                },
                                child: Text('Scan Qr code'.tr)),
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
              'To make an order click the button below.'.tr,
              style: TextStyle( fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 19)),
        ElevatedButton(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10)),
         onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => Service_form()));
             }, child: Text('Make an Order'.tr,style: TextStyle(color:Colors.white, fontSize: 16),),
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
               Text('Delivery Items:'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
               Text({snap.Items}.toString().substring(2, len)),
             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text('Pick up detail:'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
               Row(
                 children: [
                   Text('${snap.Floor_pickup} ${check(snap.Floor_pickup)} Floor,'.tr),
                   Text(snap.has_elevator_pickup ? ' with an elevator': 'With no elevator'.tr)],
               ),

             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text('Destination detail:'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
             Row ( children:[
                 Text('${snap.Floor_destination} ${check(snap.Floor_pickup)} Floor,'.tr),
               Text(snap.has_elevator_destination ? ' with an elevator'.tr: 'With no elevator'.tr)
             ])

             ],
           ),
         ),
         Padding(
           padding: const EdgeInsets.all(5.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text('Payment information:'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
               Row(
                 children: [
                   Text('${snap.Payment} Br.'.tr),
                   Text(snap.Payment_status == 'Paid'.tr ? ' All paid'.tr: 'not yet paid'.tr)],
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
    return FutureBuilder(
      future: gethistory(),
      builder:(context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: CircularProgressIndicator(
                  color: Colors.black12,
                ));
        // case (ConnectionState.done) :
          default:
            List<Widget> cards = [];
            for(int i = 0; i < snapshot.data.length; i++){
              print('we here');
              cards.add(
                  Card(
                    child: snapshot.data[i].Order_ID == null ?
                    // child: false ?
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text('There are no past orders in your history. ',
                              style: TextStyle(fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 19)),
                        ],
                      ),
                    ) :
                    ExpandablePanel(
                      header: Text('${snapshot.data[i].Order_ID}'),
                      collapsed: Text('${DateFormat('yyyy-MM-dd - h:mm a').format(snapshot.data[i].Pickupdate)}'),
                      expanded: Column(
                        children: [
                          Text(snapshot.data[i].Order_status),
                        ],
                      ),
                    ),
                  )
              );
            }
            return ListView(
              children: cards,
            );
        }
      }
      );
  }

final qr_key = GlobalKey(debugLabel: 'Qr');
QRViewController? controller;
Barcode? Qrcode;

// @override
// void dispose(){
//   super.dispose();
// }

@override
void reassemble() async{
  super.reassemble();

  controller!.pauseCamera();

  controller!.resumeCamera();
}

@override
Widget Qr_view(BuildContext context) {
  return SafeArea(child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          build_Qr_view(context),
          Positioned(bottom: 20, child: build_result()),
        ],
      ))
  );
}

Widget build_Qr_view(BuildContext context) => QRView(
  key: qr_key,
  onQRViewCreated: onQRViewCreated,
  overlay: QrScannerOverlayShape(
    cutOutSize: MediaQuery.of(context).size.width*0.8,
    borderWidth:  10,
    borderLength: 20,
    borderRadius: 10,),
  onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),

);

Widget build_result() => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70
    ),
    child: Text(Qrcode != null ? 'Result: ${Qrcode!.code}':'Scan Qr code'.tr));

void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  if (!p) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('no Permission'.tr)),
    );
  }
}
bool i = false;

void onQRViewCreated(QRViewController controller){
  final user = Provider.of<UserFB?>(context, listen: false);
  setState(() => this.controller = controller);
  setState(() {
    this.Qrcode = Qrcode;
  });
  controller.scannedDataStream.listen((Qrcode) async{
    print(Qrcode!.code);
        bool checked =
            await DatabaseService(uid: user!.uid).checkdriver(Qrcode!.code);
        print(checked);
        if (checked) {
          await DatabaseService(uid: user!.uid).finishOrder(Qrcode!.code);
          await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Rating(Qrcode!.code)));
        }
    });
}



}

