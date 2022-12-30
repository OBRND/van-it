import 'package:flutter/material.dart';

class Special_details extends StatefulWidget {
  const Special_details({Key? key}) : super(key: key);

  @override
  State<Special_details> createState() => _Special_detailsState();
}

class _Special_detailsState extends State<Special_details> {
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
              tag: 'Special',
              child: Text('Special moving',
                  style: TextStyle(fontSize: 20, color: Colors.black))),
        ], ),
    );
  }
}
