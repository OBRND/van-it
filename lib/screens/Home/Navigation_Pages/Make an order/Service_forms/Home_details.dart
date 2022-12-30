import 'package:flutter/material.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make_order.dart';

class Home_details extends StatefulWidget {
  const Home_details({Key? key}) : super(key: key);

  @override
  State<Home_details> createState() => Home_detailsState();
}

class Home_detailsState extends State<Home_details> {

  List<Actor> cast = <Actor>[
    const Actor('Boxes', '15'),
    const Actor('Chair', '4'),
    const Actor('Table', '1'),
    const Actor('Bed', '1'),
    const Actor('Bag', '4'),
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
  int choice = 0;
  String selectedValue = "0";
  String selectedValue2 = "0";
  bool _isSelected =  false;
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("     0"),value: "0"),
      DropdownMenuItem(child: Text("     1"),value: "1"),
      DropdownMenuItem(child: Text("     2"),value: "2"),
      DropdownMenuItem(child: Text("     3"),value: "3"),
      DropdownMenuItem(child: Text("     4"),value: "4"),
    ];
    return menuItems;
  }
List _choices = ['Small','Medium','Large', 'Huge'];
  int _choiceIndex = 0;
  bool isChecked1 = false;
  bool isChecked = false;
  String choicetype = 'Small';

  late List Total_choices = [
    // choicetype, {
    //   for (int i = 0; i < cast.length; i++) {
    //     cast[i].name,
    //     cast[i].initials,
    //   },},
    // Prefered_Items,
    // selectedValue,
    // isChecked1,
    // selectedValue2,
    // isChecked
  ];
  String Prefered_Items = 'None';
  List Choices = [];
  List Items= ['','','','','',''];
  void items() {
    for (int i = 0; i < cast.length; i++)
  setState(() => Items[i] = cast[i].name + cast[i].initials);
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
            child: Text('Home moving',
                style: TextStyle(fontSize: 20, color: Colors.black))) ,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  _buildChoiceChips(),
                //   Padding(
                //     padding: const EdgeInsets.fromLTRB(18,0, 20, 5),
                //     child: ToggleButtons(
                //     direction: Axis.vertical,
                //     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,),
                //     children: <Widget>[
                //      Text('Small'),
                //      Text(' Medium '),
                //      Text('large'),
                //      Text('Huge'),
                //     ],
                //     borderWidth: 1,
                //     fillColor: Colors.blueAccent,
                //     borderRadius: const BorderRadius.all(Radius.circular(8)),
                //     selectedColor: Colors.white,
                //     onPressed: (int index) {
                //       setState(() {
                //         for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                //           if (buttonIndex == index) {
                //             isSelected[buttonIndex] = true;
                //             choice = buttonIndex;
                //           } else {
                //             isSelected[buttonIndex] = false;
                //           }
                //         }
                //       }
                //       );print('$isSelected');
                //     },
                //     isSelected: isSelected,
                // ),
                //   ),
                Expanded(child: build_details())
                ]
              ),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Other non-listed Items',
                  labelText: 'What other items did we miss',
                ),
                  onChanged:(val){
                  setState(() => Prefered_Items = val);
                  }
              ),
              SizedBox(height: 30),
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
                    items: dropdownItems
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
                          items: dropdownItems
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
                items();
                setState(() {
                  Choices = Total_choices = [
                  choicetype,

                    // {for (int i = 0; i < cast.length; i++) {
                    //  Items[i]: { cast[i].name,
                    //  cast[i].initials}
                    // },
                  Prefered_Items,
                  selectedValue,
                  isChecked1,
                  selectedValue2,
                  isChecked
                ];});
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Make_order(Choices, Items)));
                },
                  style: TextButton.styleFrom(primary: Colors.green),
                  child: Text('Proceed')),
            ], ),
        ),
      ),
    );
  }

  Widget _buildChoiceChips() {
    return Container(
      height:200,
      width: 80,
      child: ListView.builder(
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
                  choicetype = 'Small';
                  cast = [
                    const Actor('Boxes', '15'),
                    const Actor('Chair', '4'),
                    const Actor('Table', '1'),
                    const Actor('Bed', '1'),
                    const Actor('Bag', '4'),
                  ];
                }
                  else if (choice == 1){
                    choicetype = 'Medium';
                  cast = [
                    const Actor('Chair', '6'),
                    const Actor('Box', '30'),
                    const Actor('Sofa', '1'),
                    const Actor('Table', '2'),
                    const Actor('Bed', '2'),
                    const Actor('Book Shelf', '1'),
                  ]; } else if (choice == 2){
                  setState((){
                    choicetype = 'Large';
                  cast = [
                    const Actor('Chair', '10'),
                    const Actor('Box', '50'),
                    const Actor('Sofa set', '2'),
                    const Actor('Table', '3'),
                    const Actor('Bed', '4'),
                    const Actor('Book Shelf', '2'),
                  ]; });}
                      else if (choice == 3){
                        choicetype = 'Huge';
                  cast = [
                    const Actor('Boxes', '99'),
                    const Actor('Chair', '15'),
                    const Actor('Sofa set', '3'),
                    const Actor('Table', '2'),
                    const Actor('Bed', '6'),
                    const Actor('Book Shelf', '4'),
                  ]; }
              });
            },
            // backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  Widget _buildInputChips() {
    return InputChip(
      padding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.pink.shade600,
        child: Text('FD'),
      ),
      label: Text('Flutter Devs',style: TextStyle(color:
      _isSelected?Colors.white:Colors.black),
      ),
      selected: _isSelected,
      selectedColor: Colors.blue.shade600,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
      // onDeleted: () {
      // },
    );
  }

  Widget build_details() {
    if (choice == 0) {
      return Container(
        width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Small house package',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Mini-van '),
                  InkWell(
                    child: Icon(Icons.info_outline),
                    onTap: () {
                      for (int i=0 ; i < cast.length; i++)
                        print(cast[i].name);
                      print('nonono');
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
        width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Medium house package',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Isuzu medium sized'),
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
        width: 220,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('Large house package',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
              Row(
                children: [
                  Text('Vehicle: Enclosed Isuzu FSR  '),
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
          width: 220,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Huge house package',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  Row(
                    children: [
                      Text('Vehicle: Iveco '),
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

class Actor {
  const Actor(this.name, this.initials);
  final String name;
  final String initials;
}
