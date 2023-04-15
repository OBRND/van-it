

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:van_lines/screens/Authentication/Sign_up.dart';
import 'package:van_lines/screens/Authentication/forgotpassword.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/shared/decorations.dart';

import 'package:lottie/lottie.dart';
import 'package:van_lines/screens/Authentication/Sign_in.dart';

class Sign_in extends StatefulWidget {
  final Function switchview;
  Sign_in({required this.switchview});

  @override
  State<Sign_in> createState() => _Sign_inState();
}
class _Sign_inState extends State<Sign_in> {

  final Auth_service _auth= Auth_service();
  final _formkey = GlobalKey<FormState>();
  //text field states
  String email = '';
  String password = '';
  String error ='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //loading ? Loading()
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(

          children:[
            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.fromLTRB(0.0,1,0.0,0.0),
              child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_b2wh1pxg.json'),
            ),
            Form(
              key: _formkey,
              child: ListView(

                padding: EdgeInsets.only(top: 150,left:20,right: 20),
                children: [
                  SizedBox( height: MediaQuery.of(context).size.height*0.2),

                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('Moving made easy...', style: TextStyle(color: Colors.black54,
                        fontWeight: FontWeight.w600, fontSize: 25),),
                  ),



                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                  TextFormField(

                    // decoration: textinputdecoration.copyWith(hintText: ' Email'),
                    validator: validateemail,

                    onChanged: (val){
                      setState(() => email = val);
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email
                      ),
                      hintText: 'Enter email address',
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox( height: 20),
                  TextFormField(
                    // decoration: textinputdecoration.copyWith(hintText: ' Password'),
                    validator: (val) => val!.length <6 ? ' Enter password more that 6 characters' : null,

                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(
                        Icons.key,
                      ),
                      hintText: 'Enter password',
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox( height: 10),
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Text(error,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton.icon(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          textStyle: TextStyle(fontSize: 15)
                      ),
                      icon: Icon(Icons.key,size: 20,),
                      label: Text('Reset Password'),
                      onPressed:() {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => forgotpassword(),
                        ));
                      }
                      ),
                  ElevatedButton(
                      child: Text("Login",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white54),)),
                          backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 7, 255, 172))),
                      onPressed: () async{
                        if(_formkey.currentState!.validate()){
                          // setState(() => loading = true);
                          dynamic result = await _auth.Signin_WEP(email, password);
                          // Navigator.push(context, new MaterialPageRoute(builder: (context) => new Profile(result: new result("Priyank","28"))));
                          if(result == null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Could not sign in with those credentials')),
                            );
                            setState(() {
                              error = 'Could not sign in with those credentials';
                              // loading = false;
                            });
                          }
                        }
                      }
                  ),
                  ElevatedButton(

                    child: Text("Sign in",
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    style: ButtonStyle(

                      // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      //     RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(18.0),
                      //         side: BorderSide(color: Colors.white54),)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 255, 255, 255))),
                    onPressed: () async{
                      widget.switchview();
                    },
                  ),
                  SizedBox(height: 2,),

                ],
              ),
            ),
          ]
      ),
    );
  }
}
String? validateemail(String? email) {
  if (email == null || email.isEmpty)
    return 'email address is required';
  else if (!email.contains('@')) return 'email is not validate';

  return null;
}