import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/main.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Contactus/customer_support.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:van_lines/services/map_services.dart';
import 'package:van_lines/trial.dart';
import 'package:http/http.dart' as http;

class Contact_us extends StatefulWidget {
  @override
  State<Contact_us> createState() => _Contact_usState();
}

class _Contact_usState extends State<Contact_us> {
  // const Contact({Key? key}) : super(key: key);
  String name = '';
  String email ='';
  String message = '';
  String subject = '';

  @override
  Widget build(BuildContext context) {
    String label='Name';
    String labe4='write your message here';
    String labe2='Subject';
    String labe3='your email';
    String hint1='Write your name';
    String hint2='Enter your email so we can reach you';
    String hint3='write the Subject';
    String hint4='What can we help you with';

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      drawer: NavigationDrawerModel(),
      appBar: AppBar(
        elevation: 0,
        title: Text('Contact Us'.tr),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Wrap(
          children:[
           // Text('Name'),
           TextFormField(decoration: InputDecoration(
             filled: true,
             fillColor: Colors.white,
             hintText: hint1.tr,
             labelText: label.tr,
           ),
             onChanged:(val){
               setState(() => name = val);
             },

          ),
            // Text('Subject'),
            TextFormField(decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint2.tr,
              labelText: labe3.tr,
            ),
              onChanged:(val){
                setState(() => email = val);
              },
            ),
            TextFormField(decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint3.tr,
              labelText: labe2.tr,
            ),
              onChanged:(val){
                setState(() => subject = val);
              },
            ),
            // Text('Message'),
            TextFormField(
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: hint4.tr,
                labelText: labe4.tr,
              ),
              onChanged:(val){
                setState(() => message = val);
              },
              maxLines: 6,
            ),
            Center(
              child: ElevatedButton(onPressed: (){
                sendEmail(name: name, email: email, subject: subject, message: message);
              },
              child: Text('Send'.tr),),
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          final user = Provider.of<UserFB?>(context, listen: false);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Chat(chatID: user!.uid)));
        },
        label: Row(
          children: [
            Text('Contact support '),
            Icon(
              Icons.contact_support
            ),
          ],
        ),
      ),

    );
  }

  Future sendEmail({
  required String name,
    required String email,
    required String subject,
    required String message,
}) async{
    final serviceId = 'service_g6ywc8k';
    final templateId = 'template_czpdj9m';
    final userId = 'QpY6Sr1SqH_sRCWy5';


    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
        url,
      headers: {
          'origin': 'http://localhost',
          'Content-type': 'application/json',
      },
      body: json.encode({
          'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),

    );

    print(response.body);

  }
}
