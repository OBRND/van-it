import 'package:flutter/material.dart';

class Furniture_details extends StatefulWidget {
  const Furniture_details({Key? key}) : super(key: key);

  @override
  State<Furniture_details> createState() => _Furniture_detailsState();
}

class _Furniture_detailsState extends State<Furniture_details> {
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
              tag: 'furniture',
              child: Text('Furniture moving',
                  style: TextStyle(fontSize: 20, color: Colors.black))),
        ], ),
    );
  }
}
