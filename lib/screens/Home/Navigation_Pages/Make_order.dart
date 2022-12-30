import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Payment_system.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Make%20an%20order/Service_forms/Home_details.dart';
import 'package:van_lines/screens/Home/Navigation_drawer.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:van_lines/services/Payment_service.dart';
import 'package:van_lines/services/map_services.dart';
import 'package:van_lines/shared/Payment_item.dart';
import '../../../models/User.dart';
import '../../../services/Database.dart';



class Make_order extends StatefulWidget {
  // const Make_order({Key? key}) : super(key: key);
  final List Total_choices;
  final List Items;
  Make_order(this.Total_choices, this.Items);


  @override
  State<Make_order> createState() => _Make_orderState(Total_choices, Items);
}
MapController controller = MapController(
  initMapWithUserPosition: false,
  initPosition: GeoPoint(latitude: 9.0099, longitude:38.7448),
  areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),

);

class _Make_orderState extends State<Make_order> {
  final List Total_choices;
  final List Items;
  _Make_orderState(this.Total_choices, this.Items);

  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
  bool isvisible = true;
  late List marker = [];
  late List user_location = services().user_position;
  DateTime dateTime = DateTime( DateTime.now().year, DateTime.now().month, DateTime.now().day,DateTime.now().hour,DateTime.now().minute);
  bool floatExtended = false;
  bool sm = false;
  bool dateIsSet = false;
  String dateDisplay = '';
  double c = 0 ;
  double  z = 0;
  var Route_distance;
  var Route_time;
  int cal = 0;
  String dis = '';
  String time = '';
  List Choices = [];
  bool ischecked = false;


  // List home_details =  Home_detailsState().Total_choices;



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserFB?>(context);
    DatabaseService databaseservice = DatabaseService(uid: user!.uid);

    var mapController = controller;
    services().locatePosition();
    select();
    services().calculate();
    dateDisplay = dateTime.toString().substring(0,16);
    if(Route_distance == null){
      setState((){
        dis = time = 'Calculating';
      });
    } else{
      setState(() {
        dis = '$Route_distance';
        time = '$Route_time';
      });
    }

    return Scaffold(

      extendBodyBehindAppBar: true,
      // extendBody: true,
      // drawer: NavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Set Address and Pickup time', style: TextStyle(color: Colors.black54)),
        // backgroundColor: Colors.blue,
      ),
      body: ExpandableBottomSheet(
        key: key,
         background: Container(
           color: Colors.red,
            child: Center(
              child: Scaffold(
              extendBodyBehindAppBar: true,
               extendBody: true,
                body: MaterialApp(
                   home: OSMFlutter(
                     controller: mapController,
                     trackMyPosition: true,
                     initZoom: 14,
                     minZoomLevel: 8,
                     maxZoomLevel: 19,
                     stepZoom: 1.0,
                     userLocationMarker: UserLocationMaker(
                       personMarker: MarkerIcon(
                         icon: Icon(
                           Icons.location_history,
                           color: Colors.red,
                           size: 48,
                         ),),
                       directionArrowMarker: MarkerIcon(
                         icon: Icon(
                           Icons.double_arrow,
                           size: 48,
                         ),
                       ),),
                     roadConfiguration: RoadConfiguration(
                       startIcon: MarkerIcon(
                         icon: Icon(
                           Icons.person,
                           size: 64,
                           color: Colors.brown,
                         ),),
                       roadColor: Colors.yellowAccent,
                     ),
                     markerOption: MarkerOption(
                         defaultMarker: MarkerIcon(
                           icon: Icon(
                             Icons.location_on,
                             color: Colors.red,
                             size: 56,
                           ),
                         )
                     ),
                   )
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
                  floatingActionButton:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width - 100,
                      // ),
                      FloatingActionButton.extended(
                      extendedPadding: EdgeInsets.all(13),
                      tooltip: 'Select a custom marker',
                      label: ElevatedButton(onPressed: (){},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) =>Colors.grey)
                        ),
                      child: Text('Slect a custom pick up location'),),
                      isExtended: floatExtended,
                      icon: Icon(
                        floatExtended == true ? Icons.close : sm == false ? Icons.radio_button_on: Icons.check,
                        color: floatExtended == true ? Colors.red : Color(0xFF3F3F41),
                      ),
                      onPressed: () {
                        setState(() {
                          floatExtended = !floatExtended;
                          sm = true;
                        });
                        },
                      backgroundColor: floatExtended == true
                          ? Colors.blueGrey : Colors.white.withOpacity(.6),
                    ),
                ]
                  ),

              ),
            ),),
          persistentHeader: Container(
          height: 100,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    label: Text( dateIsSet == true ? '$dateDisplay' : 'Set the Date of pick up',
                    style: TextStyle(color: dateIsSet == true ? Colors.black : Colors.white),),
                    backgroundColor: Colors.blueGrey,
                    onPressed: pickDateTime,
                    // print(choice);          },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton.extended(
                    label: Text('Next'),
                    backgroundColor: Colors.grey,
                    onPressed: !ischecked && dateIsSet ? (){
                      const snackBar = SnackBar(
                        content: Text('Select a destination location'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } : ischecked && !dateIsSet ?  (){
                      const snackBar = SnackBar(
                        content: Text('Set a Pickup date to proceed'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } : !ischecked && !dateIsSet ?  (){
                      const snackBar = SnackBar(
                        content: Text('Select a destination location and a Pickup date '),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } : () {
                      drawmultipleroads();
                      setState(() {
                        cal = 1;
                        key.currentState?.expand();
                        isvisible = true;});

                      },),
              ],
              ),
            ),

           ),

        expandableContent: Container(
          height: MediaQuery.of(context).size.height*.25,
          color: Colors.transparent,
          child: Visibility(
            visible: isvisible,
            child: Column(
              children: [
                _buildPlayerModelList(),
                // _buildPlayerModelList(Exptext1, route1, 1),
                // _buildPlayerModelList(Exptext2, route2, 2),
                ElevatedButton(onPressed: () async {
                  key.currentState?.contract();
                  print(marker);
                  Locations loc = Locations(start: services().user_position, destination: marker);
                  print(services().user_position);
                  List Choices = Total_choices;
                  print(Choices);
                  Payment_item items = Payment_item(
                      Service_type: 1,
                      Package: Choices[0],
                      Items: Items,
                      has_elevator_pickup: Choices[3],
                      has_elevator_destination: Choices[5],
                      Floor_pickup: int.parse(Choices[2]),
                      Floor_destination: int.parse(Choices[4]),
                      Distance: Route_distance as double);
               List pay = await Payment(order: items).Calculate();
                  // await databaseservice.orders(services().user_position, marker, Choices, dateTime,Items );
                  setState(() => isvisible = !isvisible);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Payment_system(pay: pay, order: items, locations: loc,Pickup_date: dateTime)));
                  },
                  child: Text('Submit'),
                  // color: Colors.green,
                )
              ],
            ),
          ),
    ),
    ),
    );

  }

  int index = 0;
  Widget _buildPlayerModelList() {
    return Card(
      elevation: 1,
      color: Colors.transparent,
        child: Wrap(
          children: [
            Text.rich(
        TextSpan(
            children:[
          TextSpan( text: 'The total Distance is :', style: TextStyle(color: Colors.black, fontSize: 18)),
          TextSpan( text: '$dis Km \n', style: TextStyle(color: Colors.black, fontSize: 20)),
          TextSpan( text: 'The total Duration of delivery is:', style: TextStyle(color: Colors.black, fontSize: 18)),
          TextSpan( text: '$time seconds\n', style: TextStyle(color: Colors.black, fontSize: 20)),
            ])
            )
          ],
        ),
    );
  }

  Future select() async {

    controller.listenerMapLongTapping.addListener(() async {
      if (controller.listenerMapLongTapping.value != null) {
        setState(() {
          ischecked =true;
        });
        // await controller.advancedPositionPicker();
        GeoPoint p = await controller.selectPosition();
        c =  p.latitude;
        z =  p.longitude;
        // marker = [p.latitude,p.longitude];
        setState((){
          marker = [c,z];
          // this.c = c;
          // this.z = z;
        });

        print(p.latitude);
        print(p.longitude);
        services().select(p.latitude, p.longitude);

        services().calculate();

        services.fu;
        services.gu;


      }
    });
  }
  void drawmultipleroads () async {
    // final int i = 20;
    final configs = [
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: services.fu,
          longitude:services.gu ,
        ),
        destinationPoint: GeoPoint(
          latitude: marker[0]+0.00000000000001,
          longitude: marker[1]+0.00000000000001,
        ),
        roadOptionConfiguration: MultiRoadOption(
                roadColor: Colors.orange,

              )
      ),
      // MultiRoadConfiguration(
      //     startPoint: GeoPoint(
      //       latitude: p.latitude+0.0005,
      //       longitude: (p.longitude+0.0005),
      //     ),
      //     destinationPoint: GeoPoint(
      //       latitude: services.fu,
      //       longitude: services.gu,
      //     ),
      //     roadOptionConfiguration: MultiRoadOption(
      //       roadColor: Colors.orange,
      //     )
      // ),
      // MultiRoadConfiguration(
      //   startPoint: GeoPoint(
      //     latitude: p.latitude+0.001,
      //     longitude: p.longitude+0.001,
      //   ),
      //   destinationPoint: GeoPoint(
      //     latitude: services.fu,
      //     longitude: services.gu,
      //   ),
      // )
    ];
    final listRoadInfo = await controller.drawMultipleRoad(
        configs,
        commonRoadOption: MultiRoadOption(
          roadColor: Colors.red,
          roadType: RoadType.car,)
    );
    print(listRoadInfo);
    setState(() {
      Route_distance= listRoadInfo[0].distance;
      Route_time= listRoadInfo[0].duration;
      // Config_route[1]= listRoadInfo[1];
      // Config_route[2]= listRoadInfo[2];
    });
    print (Route_distance);
    // print (Config_route[1]);
    // print (Config_route[2]);
  }
  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
  );
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: dateTime.hour,
          minute: dateTime.minute)
  );
  Future pickDateTime() async{
    DateTime? date = await pickDate();
    if(date == null) return;
    TimeOfDay? time = await pickTime();
    if(time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute
    );
    setState(() {
      this.dateTime = dateTime;
      dateIsSet = true;
    });
  }
      }
