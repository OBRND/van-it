import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:van_lines/models/history_Model.dart';
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
final CollectionReference Chats = FirebaseFirestore.instance.collection('Chats');
final CollectionReference Current = FirebaseFirestore.instance.collection('Current location');
final CollectionReference blacklist = FirebaseFirestore.instance.collection('Blacklist');
final CollectionReference History = FirebaseFirestore.instance.collection('Order_history');
final CollectionReference Drivers = FirebaseFirestore.instance.collection('Drivers');
final CollectionReference Notify = FirebaseFirestore.instance.collection('Notification');


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

  Future getchat(String chatid) async{
    List chatlist;
    DocumentSnapshot chat = await Chats.doc(chatid).get();
    // if(chat.exists){
    //   print('No chat exists');
    // }
    print('|||||||||${chat['chats']}');
    chatlist =  chat['chats'];
    return chatlist;
  }

  Future createChat() async{
  await Chats.doc(uid).set({
    'chatID': uid,
    'chats': ['sHello, Welcome to van it customer service, How can we help you?'],
    'date': DateTime.now(),
    'unread': 1,
  });
  }

  Future updatechat(String message, String chatid) async{
    List chat = await getchat(chatid);
    chat.add('r $message');
    return await Chats.doc(chatid).update({
      'chats': chat
    });

  }
  Future updateunread(String chatid) async{
  DocumentSnapshot doc = await Chats.doc(chatid).get();
  int unread = doc['unread'];
    await Chats.doc(chatid).update({
      'unread': unread + 1 ,
      'date' : DateTime.now()
    });
  }


  Future cancelorder(String type) async{
    int prev = 0;
  DocumentSnapshot snap = await Orders.doc(uid).get();
  String orderId = snap['Order_Id'];
  if(type == '0' || type == '2'|| type == '3'){
    print('kjjjjjjjjjjjj');
    DocumentSnapshot doc = await blacklist.doc('blacklist').get();
    final maped = doc.data() as Map<String, dynamic>;
    if(maped.containsKey(uid)){
     prev = doc[uid]['count'];
    }
    Map black = {'count': prev + 1,
      'reason': type == '0'? 'Changed his mind': type == '2' ? 'The order was wrong': 'Other reasons'};
    blacklist.doc('blacklist').update({
      uid: black,
      // 'reason': type == '0'? 'Changed his mind': type == '2' ? 'The order was wrong': 'Other reasons',
    });
  }
  else{
    DocumentSnapshot driverid = await Current.doc(orderId).get();
    String driverId = driverid['DriverID'];
    try {
      await blacklist.doc('blacklist').get().then((docSnapshot) {
        final data = docSnapshot.data() as Map<String, dynamic>;
      if (data.containsKey(driverId)) {
        prev = docSnapshot[driverId]['count'];
      } else {
        blacklist.doc('blacklist').update({
        driverId: {'count': 0,
          'Reposted by': uid,
          'reason': 'Driver was late'},
      });
      // create the document
      };
      blacklist.doc('blacklist').update({
      driverId: {'count' : prev +1,
        'reason': 'Driver was late',
        'Reposted by': uid,
      },
      });
      });
    } catch (e, s) {
      print(s);
    }
    // if(doc[driverId].exists){
    //   prev = doc[driverId]['count'];
    // }else prev = 0;
    // Map black = {'count': prev + 1};


  }
  print('Cancelled');
    await Orders.doc(uid).update({'Order_status': 'Cancelled'});
  DocumentSnapshot history = await Orders.doc(uid).get();
  print('History is about to commence');
  Map details = {
    'Order_ID': history['Order_Id'],
    'Items': history['Items'],
    'payment': history['Payment'],
    'Date of delivery': DateTime.now(),
    'Finish_status': 'Cancelled',
    'Service type': history['Service type'],
    'Preferences': history['Preferences']
  };

  Map v ={};
  List x = [];
    await History.get().then((QuerySnapshot snapshot) {
      print('object');
      List elements = [];
      snapshot.docs.forEach((element) {
        // elements.add(element.id);
        if(element.id == uid){
          for(int i=0; i < element['Orders'].length; i++) {
          x.add(element['Orders'][i]);
          print('added');
          print(x);
          }
        }
        else print('no');
      });
      x.add(details);
    });

    await History.doc(uid).update({
    'Orders': x,
  });
    print('all the way');
    await Current.doc(orderId).delete();
    await Orders.doc(uid).delete();
    return true;
  }

  Future getstatus() async{
  String orderId = '';
  String Status = '';
  DocumentSnapshot snap = await Orders.doc(uid).get();
  orderId = snap['Order_Id'];
  print('------------------------');

  QuerySnapshot currentstat = await Current.where('OrderID', isEqualTo: orderId).get();
  if(currentstat.docs.isNotEmpty) {
    Status = currentstat.docs[0]['Order_status'];
    print('------------${Status}------------');
    return Status;
  }
  print('------------stat------------');

  // final data = man.data() as Map<String, dynamic>;
  // if(data.containsKey(orderId)){
  //   print(']]]]]]]]]');
  // }
  // Status = status['Order_status'];

  print('----------------------iiiiiii-------------------------');
  return Status;
  }

  Future gethistory() async{
  DocumentSnapshot history = await History.doc(uid).get();
  List his = [];
  for(int i=0; i < history['Orders'].length; i++) {
    await History.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        print(element.id);
      });

    });
    // final maped = doc.data() as Map<String, dynamic>;
    // print(maped.toString());
    print('Executioner');
    print( history['Orders'][i]['payment']);
      his.add(
          history_Model(
          Pickupdate: history['Orders'][i]['Date of delivery'].toDate(),
          Order_status: history['Orders'][i]['Finish_status'],
          Order_ID: history['Orders'][i]['Order_ID'],
          Items: history['Orders'][i]['Items'],
          has_elevator_pickup: history['Orders'][i]['Preferences'][2],
          has_elevator_destination: history['Orders'][i]['Preferences'][4],
          Floor_pickup: history['Orders'][i]['Preferences'][1],
          Floor_destination: history['Orders'][i]['Preferences'][3],
          Payment: history['Orders'][i]['payment'],
          )
          );
    }
  print(his);
  return his;

  }

Future check_order() async{
  DocumentSnapshot myorder = await Orders.doc('$uid').get();
  print(myorder);
  print( myorder['Pick_Up_date']);
   if(myorder != null){
    List choices = myorder['Preferences'];
    print(choices);
    String stat = await getstatus();
    print(stat);
    order_model order_detail =
    order_model(
        Pickupdate: myorder['Pick_Up_date'].toString(),
        Order_status: stat == '' || stat.isEmpty ? myorder['Order_status'] : stat,
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

Future checkdriver(String? driverid) async{
  bool x = false;
  await Drivers.get().then((value) {
    value.docs.forEach((element) {
      if(element.id == driverid){
        x = true;
      }
    });
    return x;
  });
  return x;
}

Future updaterating(String did, double rating) async{
  DocumentSnapshot snap = await Drivers.doc(did).get();
  print(snap);
  final newrating = ((snap['count'] * snap['rating'] + rating) / snap['count'] + 1);
  await Drivers.doc(did).update({
    'rating' : newrating,
    'count' : snap['count'] + 1
  });
}
Future getNotifications() async{
    DocumentSnapshot snap = await Notify.doc('Admin messages').get();
    List messages = snap['Messages'];
    return messages;
  }

Future adddriverbalance() async{
  DocumentSnapshot snap = await Orders.doc(uid).get();
  DocumentSnapshot driver = await Current.doc(snap['Order_Id']).get();
  String driverid = driver['DriverID'];
  print('---------------');
  DocumentSnapshot driverbal = await Balance.doc(driverid).get();
  var newbal = driverbal['Amount'] + (snap['Payment'] + snap['Payment']* .15 + 300);
  await Balance.doc(driverid).update({
    'Amount': newbal
  });
  List x =[];
  Map details = {
    'Order_ID': snap['Order_Id'],
    'Items': snap['Items'],
    'payment': snap['Payment'],
    'Date of delivery': DateTime.now(),
    'Finish_status': 'Finished',
    'Service type': snap['Service type'],
    'Preferences': snap['Preferences']
  };
  DocumentSnapshot his = await History.doc('Driver history').get();
  for(int i=0; i < his[driverid].length; i++) {
    x = his[driverid];
  }
  print(x);
  x.add(details);
    await History.doc('Driver history').update({
    '$driverid': x,
  });

  print('--------${newbal}-------');
}

Future finishOrder(String? Driverid) async{
  await adddriverbalance();
  DocumentSnapshot snap = await Orders.doc(uid).get();
  String orderId = snap['Order_Id'];
    await Orders.doc(uid).update({'Order_status': 'Finished'});
    DocumentSnapshot history = await Orders.doc(uid).get();
    print('History is about to commence');
    Map details = {
      'Order_ID': history['Order_Id'],
      'Items': history['Items'],
      'payment': history['Payment'],
      'Date of delivery': DateTime.now(),
      'Finish_status': 'Finished',
      'Driver ID': Driverid,
      'Service type': history['Service type'],
      'Preferences': history['Preferences']
    };

    Map v ={};
    List x = [];
    await History.get().then((QuerySnapshot snapshot) {
      print('object');
      List elements = [];
      snapshot.docs.forEach((element) {
        // elements.add(element.id);
        if(element.id == uid){
          for(int i=0; i < element['Orders'].length; i++) {
            x.add(element['Orders'][i]);
            print('added');
            print(x);
          }
        }
        else print('no');
      });
      x.add(details);
    });

    print('all the way');
    await Current.doc(orderId).delete();
    await Orders.doc(uid).delete();
    return true;
}

Future verify_card(String entered_name, int entered_pin, int payment) async{
  DocumentSnapshot card = await Card.doc('$uid').get();
  DocumentSnapshot balance = await Balance.doc('$uid').get();
  int amount = card['Amount'];
  String full_name = card['Full name'];
  int pin = int.parse(balance['Password']);
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
      .doc(uid).get();
  print('||||||||||||||||${User_balance.data()}||||||||||||||');
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

  Future deductBalance(pay) async{
  DocumentSnapshot snap = await Balance.doc(uid).get();
  int amount = snap['Amount'];
  await Balance.doc(uid).update({
    'Amount': amount - pay
  });
}

  Future orders(Payment_item order, Locations locations,DateTime Pickup_date, pay,String unpaid) async {
    // await DatabaseService(uid: uid).updateUserData(First_name,Last_name, Phone_number);

    await deductBalance(pay);
    var x = await getuserInfo();
    String currentDate = DateTime.now().toString();
    print(DateTime.now().toString());
    print(locations.start);
    print(order.Distance);
    print(order.Package);
    print(order.Floor_pickup);
    print(order.Floor_destination);
    print(order.has_elevator_pickup);
    print(order.has_elevator_destination);
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

  Future getaccount() async{
  DocumentSnapshot snap = await Balance.doc(uid).get();
  List details = [
    snap['Account_holder'],
    snap['Amount'],
  ];
  return details;
  }

Future Deposit_Requests(String Full_name,int Amount, DateTime Date_of_request, String Reason,List Card_info) async{
    // await DatabaseService(uid: uid).updateUserData(First_name,Last_name, Phone_number);
    // var x = await getuserInfo();
    return await Deposit_requests.doc(Reason).set({
      'Full name': Full_name,
      'Amount': Amount,
      'Date of request': Date_of_request,
      'Card information': Card_info,
      'UID': uid,
      'Reason': Reason,
      'Status': 'Under review'
    });
}

Future getdriverinfo() async{
  DocumentSnapshot snap = await Orders.doc(uid).get();
  String orderid = snap['Order_Id'];
  QuerySnapshot Snapshot = await Current.where('OrderID', isEqualTo: orderid).get();
  print('${Snapshot.docs[0]['Driver']}+++++++++++++++++++');
  return Snapshot.docs[0]['Driver'];
}

Future retrievehistory() async{
  QuerySnapshot snap = await Deposit_requests.where('UID', isEqualTo: uid).get();
  List latest = [];
  List x = snap.docs.toList();
  for(int i = 0; i < snap.docs.length; i++){
    latest.add([x[i]['Amount'], x[i]['Date of request'].toDate(), x[i]['Status'], x[i]['Card information'][0]]);
  }
  print(latest);
  return latest;
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

Future cardinfo() async{
  late int card_amount;
  late String fullname;
  await Card.doc(uid).get().then((value) {
    card_amount = value['Amount'];
    fullname = value['Full name'];
  }).catchError((exception){
    print(exception.message);
    // return [0,''];
    card_amount = 0;
    fullname = '';
  });

  return [card_amount, fullname];

}

  Future balance() async{
    DocumentSnapshot User_balance = await Balance.doc(uid).get();
    int amount = User_balance['Amount'];
    List x = await cardinfo();
    print(amount);
    return [amount, x[0], x[1]];
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

  String generateOrderId() {
    var r = Random();
    const _chars = '0123456789''ABC''1234567890';
    return List.generate(6, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  }
