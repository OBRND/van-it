import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Deposit/Card_form.dart';
import 'package:get/get.dart';

class Buy_card extends StatefulWidget {
  const Buy_card({Key? key}) : super(key: key);

  @override
  State<Buy_card> createState() => _Buy_cardState();
}

class _Buy_cardState extends State<Buy_card> {

  final _formkey = GlobalKey<FormState>();
  String Fullname = '';
  String Firstname = '';
  String Middlename = '';
  String Lastname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: Text('Choose your card',),
        backgroundColor: Colors.transparent,
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.orange),
        onPressed: () => Navigator.of(context).pop(),)
      ),
      body: ListView(
        // shrinkWrap: true,
          // itemExtent: 180,
          // diameterRatio: 3,
          scrollDirection: Axis.horizontal,
          children:[
            _buildcard(cardtype: 'card 1', color: Color(0xFF090943),cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: 'John Doe', cardexpiration: '01\01\2023'),
            _buildcard( cardtype: 'card 2', color: Colors.white60, cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: 'John De', cardexpiration: '01\01\2023'),
            _buildcard( cardtype: 'card 3', color: Colors.black, cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: 'John Do', cardexpiration: '01\01\2023'),
            _buildcard( cardtype: 'card 4', color: Colors.red, cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: 'John Does', cardexpiration: '01\01\2023'),
            _buildcard( cardtype: 'card 5',color: Colors.deepPurpleAccent, cardnumber: '${DateTime.now().microsecondsSinceEpoch}', accountholder: "John Doesn't", cardexpiration: '01\01\2023'),

      ]),
    );
  }

  Widget buildform(){
    String label2='First name *';
    String label3='Middle name *';
    String label4='Last name *';

    String hint2='What is your legal First name?';
    String hint3='What is your legal Middle name?';
    String hint4='What is your legal last name?';

    return Container(

      height: 241,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration:  InputDecoration(
              hintText: hint2.tr,
              labelText: label2.tr,
            ),
            onChanged: (val){
              setState(() => Firstname = val);
            },
            validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
          ),
          TextFormField(
            decoration:  InputDecoration(
              hintText: hint3.tr,
              labelText: label3.tr,
            ),
            onChanged: (val){
              setState(() => Middlename = val);
              },
            validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
          ),
          TextFormField(
            decoration:  InputDecoration(
              hintText: hint4.tr,
              labelText: label4.tr,
            ),
            onChanged: (val){
              setState(() => Lastname = val);
            },
            validator: (val) => val!.length <3 ? 'Enter a Valid legal name' : null,
          ),
        ],
      ),
    );
  }  // final BuildContext context;
  Widget _buildcard({required String cardtype,required Color color, required String cardnumber,required String accountholder,required String cardexpiration}){
    return Container(
      // elevation: 0,
      color: Colors.transparent,
      child: Stack(
        children:[
          Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.15),
            InkWell(
              onTap: (){
                showDialog(context: context, builder: (_) => AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                  scrollable: true,
                  title: Text(
                      'We need your legal name for verification purposes'),
                  content: Form(
                      key: _formkey,
                      child: buildform()),
                  actions: [
                    TextButton(onPressed: () {
                      Fullname = '$Firstname $Middlename $Lastname';
                      print('$Firstname- $Middlename - $Lastname');
                      if (_formkey.currentState!.validate()) {
                        List card_info = [cardtype, cardnumber];
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    Card_form(Fullname, card_info)));
                      }
                    }, child: Text('Submit'))
                  ],
                ));
                },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black54),
                  ) ,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text( cardtype == 'card 1' ? '10000 Br. Credit Card for just 8,500 Br.':
                    cardtype == 'card 2' ?'20,000 Br. Credit Card for just 16,000 Br.':
                    cardtype == 'card 3' ?'30,000 Br. Credit Card for just 24,000 Br.':
                    cardtype == 'card 4' ?'50,000 Br. Credit Card for just 40,000 Br.':
                    cardtype == 'card 5' ?'100,000 Br. Credit Card for just 80,000 Br.': 'Invalid',
                      style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w500,),
                    ),
                  )
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              elevation: 5,
              color: color,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: () {
                  showDialog(context: context, builder: (_) =>
                      AlertDialog(
                        contentPadding: EdgeInsets.all(10),
                        scrollable: true,
                        title: Text(
                            'We need your legal name for verification purposes'),
                        content: Form(
                            key: _formkey,
                            child: buildform()),
                        actions: [
                          TextButton(onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Fullname = '$Firstname $Middlename $Lastname';
                              List card_info = [cardtype, cardnumber];
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Card_form(Fullname, card_info)));
                            }
                          }, child: Text('Submit'))
                        ],
                      ));
                  },
                child: Container(
                  alignment: Alignment.center,
                  height: 180,
                  width: 260,
                  padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildlogo(cardtype),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
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
          ),
        ),

          ],
        ),
          Positioned(
            top: MediaQuery.of(context).size.height*.21,
            left: MediaQuery.of(context).size.width*.646,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-20 / 360),
              child: Card(
                color: Color(0xffff9c1a),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 21, 5, 21),
                  child: Text( cardtype == 'card 1'? '15 % Off!': '20% off!', style: TextStyle(fontWeight: FontWeight.w800),),
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildlogo(String cardtype){
    print(cardtype);
    return Row(
      children: [
        Image.asset(cardtype == 'card 1' || cardtype == 'card 3' ? "Assets/fast-delivery-modified.png" : "Assets/fast-delivery.png", height: 60,width: 50,),
        // Image.asset("Assets/img1.jpg",height: 25,width: 20,),

      ],
    );
  }
}
