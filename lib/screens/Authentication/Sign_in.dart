import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/shared/decorations.dart';


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
    backgroundColor: Color(0xff6860d0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(onPressed:(){
              widget.switchview();
            },
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white54),),
              backgroundColor: Color(0xff122B91),
              extendedPadding: EdgeInsetsDirectional.only(start: 16.0, end: 20.0),
              icon: Icon(Icons.person_add_alt_1_outlined),
              label: Text('Sign up'),
            ),
          )
        ],
      ),
      body: Stack(
        children:[
          Positioned(
           top: -70,
            left: -50,
            right: MediaQuery.of(context).size.width*.4,
            child: Container(
              height: MediaQuery.of(context).size.height*0.4,
              decoration: BoxDecoration(
                color: Color(0xff1e212f),
                borderRadius: BorderRadius.all(Radius.circular(170)),
              ),
            ),
          ),
          Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox( height: MediaQuery.of(context).size.height*0.28),
                Text('  Welcome \n'
                    '  Back!', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white70),),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: ' Email'),
                    validator: (val) => val!.isEmpty ? ' Enter an email' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    }
                ),
                SizedBox( height: 20),
                TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: ' Password'),
                    validator: (val) => val!.length <6 ? ' Enter password more that 6 characters' : null,

                    obscureText: true,
                    onChanged: (val){
                      setState(() => password = val);
                    }
                ),
                SizedBox( height: 20),
                Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Text(error,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                    child: Text("Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white54),)),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueAccent)),
                    onPressed: () async{
                      if(_formkey.currentState!.validate()){
                        // setState(() => loading = true);
                        dynamic result = await _auth.Signin_WEP(email, password);
                        // Navigator.push(context, new MaterialPageRoute(builder: (context) => new Profile(result: new result("Priyank","28"))));
                        if(result == null){
                          setState(() {
                            error = 'Could not sign in with those credentials';
                            // loading = false;
                          });
                        }
                      }
                    }
                ),
                SizedBox( height: 20),

              ],
            ),
          ),
          // child: RaisedButton(
          //   child: Text('Sign in Anonymously'),
          // onPressed: () async{
          //   await Firebase.initializeApp();
          //   final authservice _auth = authservice();
          //     await _auth.signInAnnon();
          //     dynamic result = await _auth.signInAnnon();
          //     if(result == null){
          //       print('Error signing in');
          //     } else {
          //       print('signed in');
          //       print(result.uid);
          //     }
          // }
          // ),
        ),
    ]
      ),
    );
  }
}
