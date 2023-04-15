import 'package:flutter/material.dart';
import 'package:van_lines/models/Actors_choice.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make_order.dart';
import 'package:get/get.dart';

class Furniture_details extends StatefulWidget {
  const Furniture_details({Key? key}) : super(key: key);

  @override
  State<Furniture_details> createState() => _Furniture_detailsState();
}

class _Furniture_detailsState extends State<Furniture_details> {



  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("     0"),value: "0"),
    DropdownMenuItem(child: Text("     1"),value: "1"),
    DropdownMenuItem(child: Text("     2"),value: "2"),
    DropdownMenuItem(child: Text("     3"),value: "3"),
    DropdownMenuItem(child: Text("     4"),value: "4"),
  ];
  List _choices = ['Mini van','Isuzu', 'Isuzu FSR'];
  int _choiceIndex = 0;
  int choice = 0;
  List Items= ['','','','','',''];
  String choicetype = 'Mini van';
  String selectedValue = "0";
  String selectedValue2 = "0";
  bool isChecked1 = false;
  bool isChecked = false;
  List Choices = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Hero(
            tag: 'furniture',
            child: Text('Furniture Move'.tr,
                style: TextStyle(fontSize: 20, color: Colors.black))),
      ),
      body: Column(
        children:[
          _buildChoiceChips(),
          build_details(),
          SizedBox(
            height: 20,
          ),
          Text('What floor is the package at the Starting location?'.tr),
          SizedBox(height: 10),
          Row(children:[
            SizedBox(width: 30),
            DropdownButton(
                iconSize: 25,

                value: selectedValue,
                onChanged: (String? newValue){
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: menuItems
            ),
            SizedBox(width: 50),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Container(
                  color: Colors.grey,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.red,

                        value: isChecked1,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked1 = value!;
                          });
                        },),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 25, 5),
                        child: Text('Has elevetor'.tr),
                      ),],
                  ),

                ),
              ),
            ),


          ]),
          SizedBox(height: 30),

          Text('What floor is the package at Destination?'.tr),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 30),
              DropdownButton(
                  iconSize: 25,

                  value: selectedValue2,
                  onChanged: (String? newValue){
                    setState(() {
                      selectedValue2 = newValue!;
                    });
                  },
                  items: menuItems
              ),
              SizedBox(width: 50),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Container(
                    color: Colors.grey,
                    child:
                    Row(children:[
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.red,

                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 25, 5),
                        child: Text('Has elevetor'.tr),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),

          TextButton(onPressed: () {
            setState(() {
              Choices = [
                choicetype,
                'None',
                selectedValue,
                isChecked1,
                selectedValue2,
                isChecked
              ];});
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Make_order(Choices, ['Furniture item', 'Furniture item'], 3)));
          },
              style: TextButton.styleFrom(primary: Colors.green),
              child: Text('Proceed'.tr)),


        ], ),
    );
  }
  Widget build_details() {
    if (choice == 0) {
      return Container(
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Furniture less than 2 by 2 meters '.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              Row(
                children: [
                  Text('Vehicles included: Mini-Isuzu '.tr),
                ],
              ),
               // Wrap(
              //   children: actorWidgets.toList(),
              // )
            ],

          ),
        ),
      );
    }
    else if (choice == 1) {
      return Container(
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Furniture less than 4 by 2 meters'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Isuzu medium sized'.tr),

                ],
              ),
              // Wrap(
              //   children: actorWidgets.toList(),
              // )
            ],

          ),
        ),
      );
    }
    else if (choice == 2) {
      return Container(
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Furniture less than 5 by 3 meters'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Enclosed Isuzu FSR'.tr),
                  InkWell(
                    child: Icon(Icons.info_outline),
                    onTap: () {

                    },)
                ],
              ),
              // Wrap(
              //   children: actorWidgets.toList(),
              // ),

            ],
          ),
        ),
      );
    } else {
      return Container(
        // width: 220,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Exclusive company package'.tr,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  Row(
                    children: [
                      Text('Vehicle: Iveco '.tr),
                      InkWell(
                        child: Icon(Icons.info_outline),
                        onTap: () {},)
                    ],
                  ),
                  // Wrap(
                  //   children: actorWidgets.toList(),
                  // )
                ]
            ),
          )
      );
    }
  }
  Widget _buildChoiceChips() {
    return Center(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width *.9,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _choices.length,
          itemBuilder: (BuildContext context, int index) {
            return ChoiceChip(
              padding: EdgeInsets.all(5),
              label: Text(_choices[index]),
              selected: _choiceIndex == index,
              selectedColor: Colors.red,
              backgroundColor: Colors.grey,
              onSelected: (bool selected) {
                setState(() {
                  _choiceIndex = selected ? index : 0;
                  choice = _choiceIndex;
                  if (choice == 0){
                    // setState((){
                    choicetype = 'Mini van'.tr;

                  }
                  else if (choice == 1){
                    choicetype = 'Isuzu';

                     } else {
                    setState((){
                      choicetype = 'Isuzu FSR';
                     });}
                });
              },
              // backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            );
          }, separatorBuilder: (BuildContext context, int index) { return Text(' '); },
        ),
      ),
    );
  }
}
