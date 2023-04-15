import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:get/get.dart';

class About_us extends StatelessWidget {
  // const About_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            drawer: NavigationDrawerModel(),
            appBar: AppBar(
              title: Text('About us'.tr),
              backgroundColor: Colors.black12,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Van-it, a van-lines app?\n',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600)),
                          TextSpan(text: '\n',),
                          TextSpan(
                              text: 'Van it App is a revolutionary mobile application designed to simplify the process of moving for individuals,'
                                  ' families, furniture and other companies.  Our goal is to provide a stress-free moving experience by offering a comprehensive platform that connects users with reliable and professional moving services.'
                              'The system allows user to easily book their preferred moving services. Our platform offers a wide range of moving services, including packing and unpacking, loading and unloading, and transportation of goods with in app payment system.'
                          'We understand that moving can be a challenging and overwhelming task, which is why we have designed our app to offer a user-friendly interface that is easy to navigate. Our app allows users to track their move in real-time, ensuring that they are always informed'
                                  ' about the status of their move.'
                              'At Van Lines App, we are committed to providing exceptional customer service, and our team is available 24/7 to assist users with any questions or concerns they may have. We take pride in our reputation for reliability, professionalism, and quality service.'
                          'Whether you are moving locally or long-distance, Van Lines App is your one-stop-shop for all your moving needs. Download our app today and experience the convenience and ease of moving with Van Lines App.',

                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w300)),

                        ]),),
                ),

              ],
            )
        )
    );
  }


}
