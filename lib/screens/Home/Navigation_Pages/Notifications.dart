import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/services/Database.dart';

class Notifications_page extends StatefulWidget {
  const Notifications_page({Key? key}) : super(key: key);

  @override
  State<Notifications_page> createState() => _Notifications_pageState();
}

class _Notifications_pageState extends State<Notifications_page> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Notifications', style: TextStyle(color: Colors.black),),
      ),
      body: FutureBuilder(
        future: DatabaseService(uid: user!.uid).getNotifications(),
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black38,
                    ));
              default:
                List<Widget> list = [];
                for (int i = 0; i < snapshot.data.length; i++) {
                  list.add(Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(snapshot.data[i]),
                    ),
                  ));
                }
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: list,
                  ),
                );
            }
          }
      ),
    );
  }
}
