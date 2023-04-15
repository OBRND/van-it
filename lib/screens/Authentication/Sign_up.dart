import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/screens/Authentication/Authenticate.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      // backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [

        ],),
      body: Stack(


        children:[
          Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10)),
                Center(child: Lottie.network('https://assets2.lottiefiles.com/packages/lf20_onlhogk8.json',height: 200,
                    width: 300)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              padding: EdgeInsets.only(top: 200,left: 20,right: 20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox( height: 20),
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
                              backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 7, 255, 172))),
                          child: Text("Register",
                            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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

                      SizedBox( height: 0),
                      Text(error,
                          style: TextStyle(color: Colors.red)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FloatingActionButton.extended(onPressed:(){
                          widget.switchview();
                        },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),),
                          backgroundColor: Color.fromARGB(255, 37, 236, 160),
                          extendedPadding: EdgeInsetsDirectional.only(start: 16.0, end: 20.0),
                          icon: Icon(Icons.person_outline_outlined),
                          label: Text('Log in',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),),
                        ),
                      )

                    ],
                  ),
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