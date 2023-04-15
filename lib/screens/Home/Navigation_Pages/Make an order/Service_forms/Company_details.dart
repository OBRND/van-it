import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make_order.dart';

import '../../../../../models/Actors_choice.dart';
import 'package:get/get.dart';

class Company_details extends StatefulWidget {
  const Company_details({Key? key}) : super(key: key);

  @override
  State<Company_details> createState() => _Company_detailsState();
}

class _Company_detailsState extends State<Company_details> {

  List<Actor> cast = <Actor>[
     Actor('Boxes'.tr, '15'),
     Actor('Chair'.tr, '4'),
     Actor('Office desk'.tr, '1'),
     Actor('Book shelf'.tr, '1'),
     Actor('Fragile electronics'.tr, '4'),
  ];

  Iterable<Widget> get actorWidgets {
    return cast.map((Actor actor) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Chip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          // onDeleted: () {
          //   setState((){
          //     cast.removeWhere((Actor entry) {
          //
          //       return entry.name == actor.name;
          //     }
          //     );
          //   });
          //   for (int i=0 ; i<6; i++)
          //     print(cast[i].name);
          //   for (int i=0 ; i<6; i++)
          //     setState(() => (cast[i].name));
          //   setState(() => Items=[ '','','','','','','']);
          //   items();
          // },
        ),
      );
    });
  }
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("     0"),value: "0"),
    DropdownMenuItem(child: Text("     1"),value: "1"),
    DropdownMenuItem(child: Text("     2"),value: "2"),
    DropdownMenuItem(child: Text("     3"),value: "3"),
    DropdownMenuItem(child: Text("     4"),value: "4"),
  ];
  List _choices = ['Small'.tr,'Medium'.tr,'Large'.tr, 'Huge'.tr];
  int _choiceIndex = 0;
  int choice = 0;
  List Items= ['','','','','',''];
  String choicetype = 'Small';
  String selectedValue = "0";
  String selectedValue2 = "0";
  bool isChecked1 = false;
  bool isChecked = false;
  List Choices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Hero(
            tag: 'company'.tr,
            child: Text('Company moving'.tr,
                style: TextStyle(fontSize: 20, color: Colors.black))),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            Center(child: _buildChoiceChips()),
            build_details(),
            SizedBox(height: 30),
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
              items();
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
                  builder: (context) => Make_order(Choices, Items, 2)));
            },
                style: TextButton.styleFrom(primary: Colors.green),
                child: Text('Proceed'.tr)),

          ],
        ),
      ),
    );
  }
  void items() {
    for (int i = 0; i < cast.length; i++)
      setState(() => Items[i] = cast[i].name +' '+ cast[i].initials);
  }


  Widget build_details() {
    if (choice == 0) {
      return Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.indigoAccent,
                width: 2,
              ),
            borderRadius: BorderRadius.circular(20),
            // color: Colors.grey.shade200
          ),
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Small company package'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              Row(
                children: [
                  Text('Vehicles included: Mini-Isuzu '.tr),
                  InkWell(
                    child: Icon(Icons.info_outline),
                    onTap: () {
                      for (int i=0 ; i < cast.length; i++)
                        print(cast[i].name);
                      print('nonono');
                    },)
                ],
              ),
              Text('This package includes upto:'.tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Wrap(
                children: actorWidgets.toList(),
              )
            ],

          ),
        ),
      );
    }
    else if (choice == 1) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.indigoAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey.shade200
        ),
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Premium company package'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Isuzu medium sized'.tr),
                  InkWell(
                    child: Icon(Icons.info_outline),
                    onTap: () {
                      for (int i=0 ; i < cast.length; i++){
                        print(cast[i].name);
                        print(cast[i].initials);
                      }
                    },)
                ],
              ),
              Wrap(
                children: actorWidgets.toList(),
              )
            ],

          ),
        ),
      );
    }
    else if (choice == 2) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.indigoAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey.shade200
        ),
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Ulimate company package'.tr,
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
              Wrap(
                children: actorWidgets.toList(),
              ),

            ],
          ),
        ),
      );
    } else {
      return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.indigoAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
            // color: Colors.grey.shade200
          ),
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
                  Wrap(
                    children: actorWidgets.toList(),
                  )
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
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceChip(
                  padding: EdgeInsets.all(5),
                  label: Text(_choices[index]),
                  selected: _choiceIndex == index,
                  selectedColor: Colors.indigoAccent,
                  backgroundColor: Colors.grey,
                  onSelected: (bool selected) {
                    setState(() {
                      _choiceIndex = selected ? index : 0;
                      choice = _choiceIndex;
                      if (choice == 0){
                        // setState((){
                        choicetype = 'Small'.tr;
                        cast = [
                           Actor('Boxes'.tr, '15'),
                           Actor('Chairs'.tr, '4'),
                           Actor('Office desk'.tr, '1'),
                           Actor('Book shelf'.tr, '1'),
                           Actor('Fragile electronics'.tr, '4'),
                        ];
                      }
                      else if (choice == 1){
                        choicetype = 'Medium'.tr;
                        cast = [
                           Actor('Boxes'.tr, '30'),
                           Actor('Chairs'.tr, '10'),
                           Actor('Office desk'.tr, '2'),
                           Actor('Book shelf'.tr, '2'),
                           Actor('Fragile electronics'.tr, '10'),
                           Actor('Sofa set'.tr, '1'),
                        ]; } else if (choice == 2){
                        setState((){
                          choicetype = 'Large';
                          cast = [
                             Actor('Chairs'.tr, '20'),
                             Actor('Boxes'.tr, '50'),
                             Actor('Sofa set'.tr, '3'),
                             Actor('Office desk'.tr, '5'),
                             Actor('Fragile electronics'.tr, '20'),
                             Actor('Book Shelf'.tr, '6'),
                          ]; });}
                      else if (choice == 3){
                        choicetype = 'Huge'.tr;
                        cast = [
                           Actor('Boxes'.tr, '99'),
                           Actor('Chairs'.tr, '35'),
                           Actor('Sofa set'.tr, '5'),
                           Actor('Office desk'.tr, '2'),
                           Actor('Fragile electronics'.tr, '30'),
                           Actor('Book Shelf'.tr, '10'),
                        ]; }
                    });
                  },
                  // backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                Container(
                  color: _choiceIndex == index ? Colors.indigoAccent: Colors.transparent ,
                  height: 2,
                  width: 20,)
              ],
            );
          }, separatorBuilder: (BuildContext context, int index) { return Text(' '); },
        ),
      ),
    );
  }
}
