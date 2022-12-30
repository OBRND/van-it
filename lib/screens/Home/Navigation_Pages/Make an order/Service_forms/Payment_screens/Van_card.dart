import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/shared/Payment_item.dart';

import '../../../../../../models/User.dart';
import '../../../../../../services/Database.dart';
import '../../../Orders.dart';

class Van_card extends StatefulWidget {
  final pay;
  final order;
  final locations;
  final Pickup_date;
  Van_card({required this.Pickup_date,required this.pay, required this.order, required this.locations});

  @override
  State<Van_card> createState() => _Van_cardState(pay,order,locations, Pickup_date);
}

class _Van_cardState extends State<Van_card> {
  DateTime Pickup_date;
  int pay;
  Payment_item order;
  Locations locations;
  _Van_cardState(this.pay, this.order, this.locations, this.Pickup_date);
  // const Van_card({Key? key}) : super(key: key);
  String cardnumber = '1111 0000 1111 0000';

  String expdate = '01 /01/ 25';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
                child: Center(child: _buildcard()),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: build_form(),
              ),
            ],
          )

        ),
      ),
    );
  }

  final _formkey = GlobalKey<FormState>();
  String fullname = '';
  int pin = 0; 
  Widget build_form(){
    return Card(
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Enter the name on your card', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'What is the name on your card',
                    labelText: 'Full name',
                  ),
                  validator: (val) => val!.length <3 ? 'Enter the name on your card' : null,
                  onChanged:(val){
                    setState(() => fullname= val);
                  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Enter the PIN',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLength: 4,
                decoration: const InputDecoration(
                  hintText: 'The PIN',
                  ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                  validator: (val) => val!.length <4 ? 'the pin is a 4 digit number' : null,
                  onChanged:(val){
                    setState(() => pin = int.parse(val));

                  },
              ),
            ),
            Center(
              child: ElevatedButton(onPressed: ()async{
                if(_formkey.currentState!.validate()){
                  final user = Provider.of<UserFB?>(context, listen: false);
                  final uid = user!.uid;
                  error = await DatabaseService(uid: user.uid).verify_card(fullname, pin, pay);
                  print(error);
                  setState(() {
                   error = error;
                  });
                  await DatabaseService(uid: user.uid).orders(order, locations, Pickup_date, pay, 'Paid');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Orders()));
                }
              },
                // color: Color(0xff060f42),
                child: Text('Pay',style: TextStyle(color: Colors.white),),
              ),
            ),
            Card(
              elevation: 0,
              color: Colors.transparent,
              child: Wrap(
                children: [
                   Center(
                     child: error == 'Transaction completed'|| error =='' ? null : Icon(
                  FontAwesomeIcons.circleExclamation,
                  color: Colors.red,
                  size: 20,
                ),
                   ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(error,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildcard(){
    return Card(
      elevation: 5,
      color: Color(0xff060f42),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
       child: Container(
          alignment: Alignment.center,
          height: 160,
          width: 235,
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildlogo(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('$cardnumber',style: TextStyle(color: Colors.white, fontSize: 21,fontFamily: 'CourierPrime'),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('XXXXXX XXXXXX'),
                  Text(expdate)
                ],
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildlogo(){
    return Row(
      children: [
        Image.asset("Assets/download.png",height: 60,width: 50,),
        // Image.asset("Assets/img1.jpg",height: 25,width: 20,),

      ],
    );
  }
}
