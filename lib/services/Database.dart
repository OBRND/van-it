import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:van_lines/shared/Order_model.dart';

import '../shared/Payment_item.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
final CollectionReference User_info = FirebaseFirestore.instance.collection('User_information');
final CollectionReference Orders = FirebaseFirestore.instance.collection('Orders');
final CollectionReference Balance = FirebaseFirestore.instance.collection('Balance');
final CollectionReference Deposit_requests = FirebaseFirestore.instance.collection('Deposit_requests');
final CollectionReference Card = FirebaseFirestore.instance.collection('Card');


Future updateUserData(String First_name,String Last_name, String Phone_number) async{
 return await User_info.doc(uid).set({
   'First_name': First_name,
   'Last_name': Last_name,
   'Phone_number': Phone_number
 });

}
//get user stream
Stream<QuerySnapshot> get info{
  return User_info.snapshots();
}

Future check_order() async{
  print('lolololoolololoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
  DocumentSnapshot myorder = await Orders.doc('$uid').get();
  print(myorder);
  print( myorder['Pick_Up_date']);
  print('cococoococococoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
  if(myorder != null){
    List choices = myorder['Preferences'];
    print(choices);
    order_model order_detail =
    order_model(
        Pickupdate: myorder['Pick_Up_date'],
        Order_status: myorder['Order_status'],
        Order_ID: myorder['Order_Id'],
        Items: myorder['Items'],
        has_elevator_pickup: choices[2],
        has_elevator_destination: choices[4],
        Floor_pickup: choices[1],
        Floor_destination: choices[3],
        Payment: myorder['Payment'],
        Payment_status: myorder['paid_status']
    );
    print(order_detail);
    return order_detail;
  }
  else {
    return 0;
  }


}

Future verify_card(String entered_name, int entered_pin, int payment) async{
  DocumentSnapshot card = await Card.doc('$uid').get();
  int amount = card['Amount'];
  String full_name = card['Full name'];
  int pin = card['Pin'];
  if(pin == entered_pin && full_name == entered_name) {
    if (payment > amount) {
      return 'You need to secure more funds to secure this transaction. You currently only have $amount in your card.'
          ' You are ${payment - amount} Br. short to complete the payment';
    }
    else {
      await Card.doc('$uid').update({
        'Amount': (amount - payment)
      });
      return 'Transaction completed';
    }
  }
  else {
    return 'Wrong Pin or name';
  }
  }

  Future verify_wallet(String entered_name, int entered_pin, int payment) async{
    DocumentSnapshot card = await Card.doc('$uid').get();
    int amount = card['Amount'];
    String full_name = card['Full name'];
    int pin = card['Pin'];
    if(pin == entered_pin && full_name == entered_name) {
      if (payment > amount) {
        return 'You need to secure more funds to secure\br'
            ' this transaction. You currently only have\br '
            '$amount Br. in your card.\br'
            ' You are ${payment - amount} Br.\br '
            'short to complete the payment';
      }
      else {
        await Card.doc('$uid').update({
          'Amount': (amount - payment)
        });
        return 'Transaction completed';
      }
    }
    else {
      return 'Wrong Pin or name';
    }
  }


Future<String> getpassword() async{
  DocumentSnapshot User_balance = await Balance
      .doc('$uid').get();
  String password = User_balance['Password'];
  print('========= [[[[[[[ $password');
  return password;
}
  Future changePassword(String new_password) async{
  await Balance.doc('$uid').update({
    'Password': new_password
    });
    
  }

Future resetpassword(String newpassword) async{
  return await Balance.doc('$uid').set({
    'Password': newpassword
  });
}

  Future getuserInfo() async{
    // FirebaseFirestore _instance= FirebaseFirestore.instance;

    DocumentSnapshot User_Profile = await User_info
        .doc('$uid').get();
    var first = User_Profile['First_name'];
    var last = User_Profile['Last_name'];
    var phone = User_Profile['Phone_number'];

    print(first);
    print(last);
    print(phone);
    return [first,last,phone];
  }
  Future orders(Payment_item order, Locations locations,DateTime Pickup_date, pay,String unpaid) async {
    // await DatabaseService(uid: uid).updateUserData(First_name,Last_name, Phone_number);
    var x = await getuserInfo();
    String currentDate = DateTime.now().toString();
    print(DateTime.now().toString());
    print(Pickup_date);
    return await Orders.doc(uid).set({
      'Starting_address': locations.start,
      'Destination_address': locations.destination,
      'User_Info': x,
      'Pick_Up_date': Pickup_date,
      'Date_of_request': currentDate,
      'Preferences': [
        order.Package,
        order.Floor_pickup,
        order.has_elevator_pickup,
        order.Floor_destination,
        order.has_elevator_destination
      ],
      'Order_status': 'pending',
      'Items': order.Items,
      'Payment': pay,
      'Service type': order.Service_type,
      'paid_status': unpaid,
      'Order_Id': generateOrderId()
    });
  }
Future Deposit_Requests(String Full_name,int Amount, DateTime Date_of_request, String Reason,List Card_info) async{
    // await DatabaseService(uid: uid).updateUserData(First_name,Last_name, Phone_number);
    // var x = await getuserInfo();
    return await Deposit_requests.doc(' $Reason ').set({
      'Full name': Full_name,
      'Amount': Amount,
      'Date of request': Date_of_request,
      'Card information': Card_info,
      'UID': uid,
      'Reason': Reason
    });
}
  Future getOrderlocations() async {
    // FirebaseFirestore _instance= FirebaseFirestore.instance;

    DocumentSnapshot User_Profile = await Orders
        .doc('$uid').get();
    List start = User_Profile['Starting_address'];
    List destination = User_Profile['Destination_address'];
    print(start[0]);
    print(start[1]);
        return [start[0],start[1], destination[0],destination[1]];
}
  Future balance() async{
    DocumentSnapshot User_balance = await Balance
        .doc('$uid').get();
    int amount = User_balance['Amount'];
    print(amount);
    return amount;
  }

  final DbRef = FirebaseDatabase(databaseURL: "https://van-lines-default-rtdb.europe-west1.firebasedatabase.app").ref('locations');
  Future getlocation() async {
  // final ref = FirebaseDatabase.instance.ref();
  // final snapshot = await ref.child('locations').get();
  final snapshot = await DbRef.get();
  if (snapshot.exists) {
  print(snapshot.value);
  return snapshot.value;
  } else {
  print('No data available.');
  }

  }

  
  // final ds = FirebaseDatabase.instance.ref();
  // Future update_location( ) async {
  //   ds.child('asdasd').set({
  //     'sadasd': " asdasdasd",
  //     'asdasd':" asdasdasd"
  //   });
  //   // await DbRef.set({
  //   //   'latitude': 'dsaaadasd',
  //   //   'longitude': "jkjkjkjnjkn",
  //   //   'loc': 'saasdasd',
  //   // });
  // }

  String generateOrderId() {
    var r = Random();
    const _chars = '0123456789''ABC''1234567890';
    return List.generate(6, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  }
