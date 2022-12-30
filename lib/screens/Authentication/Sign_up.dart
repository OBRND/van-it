import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/screens/Authentication/Authenticate.dart';

import '../../shared/decorations.dart';

 class Sign_up extends StatefulWidget {
   // const Sign_up({Key? key}) : super(key: key);

   late final Function switchview;
   Sign_up({required this.switchview});

   @override
   State<Sign_up> createState() => _Sign_upState();
   }
 
 class _Sign_upState extends State<Sign_up> {

   final Auth_service _auth = Auth_service();
   final _formKey = GlobalKey<FormState>();

   String email = '';
   String password = '';
   String First_name ='';
   String Last_name ='';
   String Phone_number = '';
   String error ="";
   @override
   Widget build(BuildContext context) {

     return Scaffold(
       extendBodyBehindAppBar: true,
       backgroundColor: Colors.white60,
       // backgroundColor: Colors.deepPurple,
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         title: Text('Sign up to Van-it', style: TextStyle(fontSize: 24),),
         actions: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: FloatingActionButton.extended(onPressed:(){
               widget.switchview();
             },
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(18.0),
                 side: BorderSide(color: Color(0xffd7d7d7)),),
               backgroundColor: Color(0xff122b91),
               extendedPadding: EdgeInsetsDirectional.only(start: 16.0, end: 20.0),
               icon: Icon(Icons.person_outline_outlined),
               label: Text('Sign in'),
             ),
           )
         ],),
       body: Stack(

         children:[
           Positioned(
             top: -70,
             left: -40,
             right: MediaQuery.of(context).size.width*.4,
             child: Container(
               height: MediaQuery.of(context).size.height*0.4,
               decoration: BoxDecoration(
                 color: Color(0xff1e212f),
                 borderRadius: BorderRadius.all(Radius.circular(170)),
               ),
             ),
           ),

           Padding(
             padding: const EdgeInsets.only(top: 100),
             child: Container(
             padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
             child: Form(
               key: _formKey,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                   SizedBox( height: 10),
                   TextFormField(
                       decoration: textinputdecoration.copyWith(hintText: 'Email'),
                       validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                       onChanged: (val){
                         setState(() => email = val);
                       }
                   ),
                   SizedBox( height: 10),
                   TextFormField(
                       decoration: textinputdecoration.copyWith(hintText: 'Password'),
                       validator: (val) => val!.length < 6 ? 'Enter password more that 6 characters' : null,
                       obscureText: true,
                       onChanged: (val){
                         setState(() => password = val);
                       }
                   ),
                   SizedBox( height: 10),
                   TextFormField(
                       decoration: textinputdecoration.copyWith(hintText: 'First Name'),
                       validator: (val) => val!.isEmpty ? 'Enter First' : null,
                       onChanged: (val){
                         setState(() => First_name = val);
                       }
                   ),
                   SizedBox( height: 10),
                   TextFormField(
                       decoration: textinputdecoration.copyWith(hintText: 'Last Name'),
                       validator: (val) => val!.isEmpty ? 'Enter Last name' : null,
                       onChanged: (val){
                         setState(() => Last_name = val);
                       }
                   ),
                   SizedBox( height: 10),
                   TextFormField(
                      keyboardType: TextInputType.number,
                       inputFormatters: <TextInputFormatter>[
                         FilteringTextInputFormatter.digitsOnly
                       ],
                       decoration: textinputdecoration.copyWith(hintText: 'Phone number'),
                       validator: (val) => val!.length == 10 ?   null : 'Please enter a 10 digit phone number ',
                       onChanged: (val){
                         setState(() => Phone_number = val );
                       }
                   ),
                   SizedBox( height: 10),
                   ElevatedButton(
                       style: ButtonStyle(
                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                               RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(18.0),
                                 side: BorderSide(color: Colors.white54),)),
                           backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                       child: Text("Register",
                         style: TextStyle(color: Colors.white),
                       ),
                       onPressed: () async{
                         if(_formKey.currentState!.validate()){
                         //   setState(() => loading = true);
                           dynamic result = await _auth.registerWEP(email, password,First_name, Last_name, Phone_number);
                           if(result == null){
                             setState((){ error ='please supply a valid email';
                         //     loading = false;
                             });
                           }
                         }
                       }
                   ),
                   SizedBox( height: 20),
                   Text(error,
                       style: TextStyle(color: Colors.red)
                   )
                 ],
               ),
             ),
         ),
           )],
       ),
   //   );
   // }
     );
   }
 }
 