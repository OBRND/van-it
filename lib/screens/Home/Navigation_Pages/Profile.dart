import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:van_lines/services/Auth.dart';
import 'package:van_lines/services/Database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_lines/services/Storage.dart';
import 'package:van_lines/shared/decorations.dart';
import 'package:get/get.dart';

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
      drawer: NavigationDrawerModel(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Profile'.tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                colors:[
                  Color(0xFF1280B9),
                  Color(0xffeeeaee),
                  Color(0xffeeeaee),
                  Color(0xffeeeaee),
                ])
        ),
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // padding: EdgeInsets.all(10),
                children: [
                SizedBox(height: MediaQuery.of(context).size.height *.15,),
                CircleAvatar(
                  radius: 50,
                  foregroundImage: FileImage(image),
                ),
                  TextButton(onPressed: chooseImage,
                      child: Icon(Icons.edit, color: Colors.black,)),
                  SizedBox(height: 30),
                  Text('Your profile info'.tr,
                    style: TextStyle(fontSize: 20, color: Colors.black),),
                SizedBox(height: 10),
                  TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: first),
                    validator: (val) => val!.length < 4 ? 'Enter a valid first name'.tr : null,
                    // obscureText: true,
                    onChanged: (val){
                      setState(() => first = val);
                    }
                ),
                  SizedBox(height: 4,),
                  TextFormField(
                  decoration: textinputdecoration.copyWith(hintText: last),
                  validator: (val) => val!.length <4 ? 'Enter a valid last name'.tr : null,
                  // obscureText: true,
                  onChanged: (val){
                    setState(() => last = val);
                  }
              ),
                  SizedBox(height: 4,),
                  TextFormField(
                    decoration: textinputdecoration.copyWith(hintText: phone),
                      // obscureText: true,
                    onChanged: (val){
                     if (isphonevalid (val)) {
                       setState(() => phone = val);
                     }
                    },
                      validator: (val) => isphonevalid(val!) ? null: 'Enter a valid phone number'.tr,

          ),
                 TextButton(
                   onPressed: () async{
                     if(_formkey.currentState!.validate()){
                       //   setState(() => loading =
                       dynamic result = await DatabaseService(uid: user.uid).updateUserData(first,last, phone);
                       // dynamic result = await _auth.registerWEP(email, password,First_name, Last_name, Phone_number);
                       if(result == null){
                         setState((){error ='Success!'.tr;
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
                     child: Text("Edit data".tr)
                 ),
                Text(error,
                  style: TextStyle(color: Colors.red),
                )
              ],
    ),
            ),
          ),
    )
    );
  }
  chooseImage() async{
    // final FirebaseStorage storage = FirebaseStorage.instance;
    final user = Provider.of<UserFB?>(context, listen: false);
    // Auth_service auth_service =Auth_service();
    final uid = user!.uid;
    final getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(getImage!.path);
    print(pickedImageFile);
    final Storage storage = Storage();
    await storage.uploadfile(pickedImageFile, uid);
    setState(() {
      image = pickedImageFile;
    });
  }

}
