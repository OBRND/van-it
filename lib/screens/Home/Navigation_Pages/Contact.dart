import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:van_lines/main.dart';
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
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text('Contact Us'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Wrap(
          children:[
           // Text('Name'),
           TextFormField(decoration: const InputDecoration(
             filled: true,
             fillColor: Colors.white,
             hintText: 'Write your name',
             labelText: 'Name',
           ),
             onChanged:(val){
               setState(() => name = val);
             },

          ),
            // Text('Subject'),
            TextFormField(decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter your email so we can reach you',
              labelText: 'your email',
            ),
              onChanged:(val){
                setState(() => email = val);
              },
            ),
            TextFormField(decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'write the Subject',
              labelText: 'Subject',
            ),
              onChanged:(val){
                setState(() => subject = val);
              },
            ),
            // Text('Message'),
            TextFormField(
              textAlign: TextAlign.justify,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'What can we help you with',
                labelText: 'write your message here',
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
              child: Text('Send'),),
            )
          ]
        ),
      )

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
