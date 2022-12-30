import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_lines/shared/decorations.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // const ({Key? key}) : super(key: key);
  final _formkey = GlobalKey<FormState>();

 String Uid = '';
 String first = '';
 String last = '';
 String phone = '';
 int i = 0;
 String error ='';

  var image = File('C:\Users\OBRAND\Pictures\Rophnan - tesfa.jpg');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    // Auth_service auth_service =Auth_service();
    final uid = user!.uid;
    DatabaseService databaseservice = DatabaseService(uid: user.uid);

    Future display() async{
      List Profile = await databaseservice.getuserInfo();
      setState((){
        first = Profile[0];
        last = Profile[1];
        phone = Profile[2];
      });
    }
    if(i == 0){
    display();
    setState((){
      i = 1;
    });
    }
    bool isphonevalid(String phoneNumber) {
      String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
      var regExp = new RegExp(regexPattern);

      if (phoneNumber.length == 0) {
        return false;
      } else if (regExp.hasMatch(phoneNumber)) {
        return true;
      }
      return false;
    }


    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors:[ Color(0xFF1173A8),
                  Color(0xff4d39a1)])
        ),
          child: Form(
            key: _formkey,
            child: Column( children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(image),
              ),
                ElevatedButton(onPressed: chooseImage, child: Icon(Icons.edit)),
                SizedBox(height: 30),
                Text('Your profile info',
                  style: TextStyle(fontSize: 20, color: Colors.black),),
              SizedBox(height: 10),
                TextFormField(
                  decoration: textinputdecoration.copyWith(hintText: first),
                  validator: (val) => val!.length < 4 ? 'Enter a valid first name' : null,
                  // obscureText: true,
                  onChanged: (val){
                    setState(() => first = val);
                  }
              ),
                TextFormField(
                decoration: textinputdecoration.copyWith(hintText: last),
                validator: (val) => val!.length <4 ? 'Enter a valid last name' : null,
                // obscureText: true,
                onChanged: (val){
                  setState(() => last = val);
                }
            ),
                TextFormField(
                  decoration: textinputdecoration.copyWith(hintText: phone),
                    // obscureText: true,
                  onChanged: (val){
                   if (isphonevalid (val)) {
                     setState(() => phone = val);
                   }
                  },
                    validator: (val) => isphonevalid(val!) ? null: 'Enter a valid phone number',

          ),
               TextButton(
                 onPressed: () async{
                   if(_formkey.currentState!.validate()){
                     //   setState(() => loading =
                     dynamic result = await DatabaseService(uid: user.uid).updateUserData(first,last, phone);
                     // dynamic result = await _auth.registerWEP(email, password,First_name, Last_name, Phone_number);
                     if(result == null){
                       setState((){error ='Success!';
                       });
                     } else{
                       setState((){  error ='Sorry, an error occured, try again later';
                       });
                     }
                   }
                  // print(await databaseservice.getuserInfo());
                  // List Profile = await databaseservice.getuserInfo();
                  //  setState((){
                  //    first = Profile[0];
                  //    last = Profile[1];
                  //    phone = Profile[2];
                  //  });
                 },
                   child: Text("Edit data")
               ),
              Text(error,
                style: TextStyle(color: Colors.red),
              )
            ],
    ),
          ),
    )
    );
  }
  chooseImage() async{
    final getImage = await ImagePicker().getImage(source: ImageSource.gallery);
    final pickedImageFile = File(getImage!.path);
    setState(() {
      image = pickedImageFile;
    });
  }

}
