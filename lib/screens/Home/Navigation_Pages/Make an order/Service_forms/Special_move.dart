import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make_order.dart';

class Special_details extends StatefulWidget {
  const Special_details({Key? key}) : super(key: key);

  @override
  State<Special_details> createState() => _Special_detailsState();
}

class _Special_detailsState extends State<Special_details> {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("     0"),value: "0"),
    DropdownMenuItem(child: Text("     1"),value: "1"),
    DropdownMenuItem(child: Text("     2"),value: "2"),
    DropdownMenuItem(child: Text("     3"),value: "3"),
    DropdownMenuItem(child: Text("     4"),value: "4"),
  ];
  List _choices = ['Special wrapping', 'With refrigeration'];
  int _choiceIndex = 0;
  int choice = 0;
  List Items= ['','','','','',''];
  String choicetype = 'Special wrapping';
  String selectedValue = "0";
  String selectedValue2 = "0";
  bool isChecked1 = false;
  bool isChecked = false;
  List Choices = [];
  int initQty = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Hero(
            tag: 'Special',
            child: Text('Special moving',
                style: TextStyle(fontSize: 20, color: Colors.black))),
      ),
      body: Column(
        children:[
          _buildChoiceChips(),
          build_details(),
          SizedBox(
            height: 20,
          ),
          Text('What floor is the package at the Starting location?'),
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
                        child: Text('Has elevetor'),
                      ),],
                  ),

                ),
              ),
            ),


          ]),
          SizedBox(height: 30),

          Text('What floor is the package at Destination?'),
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
                        child: Text('Has elevetor'),
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
                builder: (context) => Make_order(Choices, ['$initQty'], 4)));
          },
              style: TextButton.styleFrom(primary: Colors.green),
              child: Text('Proceed')),


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
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text('Vehicles included: Mini-Isuzu '),
             ),
              Center(
                child: Text('How many boxes are required?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                TextButton(onPressed:initQty < 1 ? null :  (){
                  setState(() {
                    initQty--;
                  });
                }, child: Text('-')),
                Text('$initQty',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.blueAccent),
                ),
                TextButton(onPressed: initQty > 29? null :(){
                  setState(() {
                    initQty++;
                  });
                }, child: Text('+')),
              ],

              )
              // Wrap(
              //   children: actorWidgets.toList(),
              // )
            ],

          ),
        ),
      );
    }
    else {
      return Container(
        // width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Text('Vehicles included: Mini-Isuzu with refrigeration'),
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
                    choicetype = 'Special wrapping';

                  }
                  else if (choice == 1){
                    choicetype = 'Refrigeration';
                    initQty = 30;

                  }
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
