import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make_order.dart';

import '../../../../../models/Actors_choice.dart';
import 'package:get/get.dart';

class Home_details extends StatefulWidget {
  const Home_details({Key? key}) : super(key: key);

  @override
  State<Home_details> createState() => Home_detailsState();
}

class Home_detailsState extends State<Home_details> {

  List<Actor> cast = <Actor>[
     Actor('Boxes'.tr, '15'),
     Actor('Chair'.tr, '4'),
     Actor('Table'.tr, '1'),
     Actor('Bed'.tr, '1'),
     Actor('Bag'.tr, '4'),
  ];

  Iterable<Widget> get actorWidgets {
    return cast.map((Actor actor) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Chip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          onDeleted: () {
            setState((){
              cast.removeWhere((Actor entry) {

                return entry.name == actor.name;
              }
              );
            });
            for (int i=0 ; i<6; i++)
              print(cast[i].name);
            for (int i=0 ; i<6; i++)
              setState(() => (cast[i].name));
              setState(() => Items=[ '','','','','','','']);
            items();
            },
        ),
      );
    });
  }

  List<bool> isSelected = <bool>[true, false, false,false];
  String label1="What other items did we miss";
  String hint1="Other non-listed Items";
  int choice = 0;
  String selectedValue = "0";
  String selectedValue2 = "0";
  bool _isSelected =  false;
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("     0  "),value: "0"),
      DropdownMenuItem(child: Text("     1  "),value: "1"),
      DropdownMenuItem(child: Text("     2  "),value: "2"),
      DropdownMenuItem(child: Text("     3  "),value: "3"),
      DropdownMenuItem(child: Text("     4  "),value: "4"),
    ];
    return menuItems;
  }
List _choices = ['Small'.tr,'Medium'.tr,'Large'.tr, 'Huge'.tr];
  int _choiceIndex = 0;
  bool isChecked1 = false;
  bool isChecked = false;
  String choicetype = 'Small';

  late List Total_choices = [ ];
  String Prefered_Items = 'None';
  List Choices = [];
  List Items= ['','','','','',''];
  void items() {
    for (int i = 0; i < cast.length; i++)
  setState(() => Items[i] = cast[i].name +''+ cast[i].initials);
  }
  @override
  Widget build(BuildContext context) {
    // items();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Hero(
            tag: 'home',
            child: Text('Home moving'.tr,
                style: TextStyle(fontSize: 20, color: Colors.black54))) ,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height* .88,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Center(child: _buildChoiceChips()),
                  build_details(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: TextFormField(
                      decoration:  InputDecoration(
                        hintText: hint1.tr,
                        labelText: label1.tr,
                      ),
                        onChanged:(val){
                        setState(() => Prefered_Items = val);
                        }
                    ),
                  ),
                  SizedBox(height: 30),
                  Text('What floor is the package at Pickup?'.tr, style: TextStyle(color: Colors.black54),),
                  SizedBox(height: 10),
                  Row(children:[
                    SizedBox(width: 30),
                    Card(
                      color: Colors.white60,
                      child: DropdownButton(
                        iconEnabledColor: Colors.blueAccent,
                          iconSize: 25,
                          value: selectedValue,
                          onChanged: (String? newValue){
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: dropdownItems
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Card(
                          color: Colors.grey[300],
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

                  Text('What floor is the package at Destination?'.tr, style: TextStyle(color: Colors.black54),),
                  SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          Card(
                            color: Colors.white60,
                            child: DropdownButton(
                              iconSize: 25,
                                iconEnabledColor: Colors.blueAccent,
                                value: selectedValue2,
                                onChanged: (String? newValue){
                                  setState(() {
                                    selectedValue2 = newValue!;
                                  });
                                },
                                items: dropdownItems
                            ),
                          ),
                          SizedBox(width: 50),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                              child: Card(
                                color: Colors.grey[300],
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
                ],),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(onPressed: () {
                  items();
                  setState(() {
                    Choices = Total_choices = [
                      choicetype,
                      Prefered_Items,
                      selectedValue,
                      isChecked1,
                      selectedValue2,
                      isChecked
                    ];});
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Make_order(Choices, Items, 1)));
                },
                    style: TextButton.styleFrom(primary: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Continue'.tr, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                        Icon(Icons.double_arrow_outlined),
                      ],
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChips() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * .75,
      child: Center(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _choices.length,
          separatorBuilder: (BuildContext context, int index) { return SizedBox(width: 10,); },
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceChip(
                  padding: EdgeInsets.all(5),
                  label: Text(_choices[index]),
                  selected: _choiceIndex == index,
                  selectedColor: Colors.blueAccent,
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
                           Actor('Chair'.tr, '4'),
                           Actor('Table'.tr, '1'),
                           Actor('Bed'.tr, '1'),
                           Actor('Bag'.tr, '4'),
                        ];
                      }
                        else if (choice == 1){
                          choicetype = 'Medium'.tr;
                        cast = [
                           Actor('Chair'.tr, '6'),
                           Actor('Boxes'.tr, '30'),
                           Actor('Sofa'.tr, '1'),
                           Actor('Table'.tr, '2'),
                           Actor('Bed'.tr, '2'),
                           Actor('Book Shelf'.tr, '1'),
                        ]; } else if (choice == 2){
                        setState((){
                          choicetype = 'Large'.tr;
                        cast = [
                           Actor('Chair'.tr, '10'),
                           Actor('Boxes'.tr, '50'),
                           Actor('Sofa set'.tr, '2'),
                           Actor('Table'.tr, '3'),
                           Actor('Bed'.tr, '4'),
                           Actor('Book Shelf'.tr, '2'),
                        ]; });}
                            else if (choice == 3){
                              choicetype = 'Huge'.tr;
                        cast = [
                           Actor('Boxes'.tr, '99'),
                           Actor('Chair'.tr, '15'),
                           Actor('Sofa set'.tr, '3'),
                           Actor('Table'.tr, '2'),
                           Actor('Bed'.tr, '6'),
                           Actor('Book Shelf'.tr, '4'),
                        ]; }
                    });
                  },
                  // backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                Container(
                  color: _choiceIndex == index ? Colors.indigoAccent: Colors.transparent ,
                  height: 4,
                  width: 20,)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget build_details() {
    if (choice == 0) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        width: MediaQuery.of(context).size.width * .9,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Small house package'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Mini-van '.tr),
                  InkWell(
                    child: Icon(Icons.info_outline),
                    onTap: () {
                      for (int i=0 ; i < cast.length; i++)
                        print(cast[i].name);
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
    else if (choice == 1) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey.shade200
        ),
        width: MediaQuery.of(context).size.width * .9,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Medium house package'.tr,
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
            color: Colors.blueAccent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey.shade200
        ),
        width: MediaQuery.of(context).size.width * .9,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Large house package'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Enclosed Isuzu FSR  '.tr),
                  InkWell(
                    child: Icon(Icons.info_outline),
                    onTap: () {

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
    } else {
      return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(20),
            // color: Colors.grey.shade200
          ),
          width: MediaQuery.of(context).size.width * .9,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Huge house package'.tr,
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

}

