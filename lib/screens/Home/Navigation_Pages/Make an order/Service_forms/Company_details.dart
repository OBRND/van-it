import 'package:flutter/material.dart';

class Company_details extends StatefulWidget {
  const Company_details({Key? key}) : super(key: key);

  @override
  State<Company_details> createState() => _Company_detailsState();
}

class _Company_detailsState extends State<Company_details> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors:[ Color(0xFF1173A8),
                Color(0xff4d39a1)])
      ),
      child: Column(
        children:[
          Hero(
            tag: 'company',
            child: Text('Company moving',
                style: TextStyle(fontSize: 20, color: Colors.black))),
        ], ),
    );
  }
}
