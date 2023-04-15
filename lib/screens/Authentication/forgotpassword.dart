import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:van_lines/services/Auth.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final email = TextEditingController();
  Future resetpassword() async {
    try {
   
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());}
         
    //           showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (context) => Dialog(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Lottie.network('https://assets6.lottiefiles.com/private_files/lf30_yo2zavgg.json'),
            
    //         const SizedBox(height: 16),
    //       ],
    //     ),
    //   )
    // ) ;
          
     // SnackBar(content: const Text('password reset email sent'));
     on FirebaseAuthException catch (e) {
      /*print(e.message);
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
   */ }
   // ignore: use_build_context_synchronously


         
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 22, 167, 154)),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_tc9h15rf.json',
                    height: 200,
                    width: 200),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  'Enter your email address',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ), // OutlineInputBorder
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color.fromARGB(255, 22, 167, 154)),
                      borderRadius: BorderRadius.circular(12),
                    ), // OutlineInputBorder
                    hintText: 'Email Address',
                    fillColor: Colors.grey[200],
                    filled: true,
                  ), // Input Decoration
                ), // Padding    );
              ),
              const SizedBox(
                height: 20,
              ),
              
              ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    textStyle: TextStyle(fontSize: 15)
                   ),
                   icon: Icon(Icons.key,size: 20,),
                   label: Text('Reset Password'),
                   onPressed: resetpassword,

            
              // Padding(
              //   padding: const EdgeInsets.only(left: 18, right: 18),
              //   child: ElevatedButton.icon(
              //       style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 22, 167, 154),
              //         minimumSize: const Size.fromHeight(40),
              //       ),
              //       onPressed: resetpassword,
              //       icon: const Icon(Icons.email_outlined),
              //       label: const Text(
              //         'Reset Password',
              //         style: const TextStyle(backgroundColor: Color.fromARGB(255, 22, 167, 154)),
              //       )),
              // ),
              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: (() {
                    resetpassword();
                  }),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 22, 167, 154),
                      borderRadius: BorderRadius.circular(10),
                    ), // BoxDecoration
                    child: Center(
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ), // TextStyle
                      ), // Text
                    ), // Center
                  ), // Container
                ), // GestureDetector
              ),*/
              )],
          ),
        ),
      ),
    );

  }
}