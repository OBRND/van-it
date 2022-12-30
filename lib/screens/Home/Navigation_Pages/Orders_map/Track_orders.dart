import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

import '../../../../models/User.dart';
import '../../../../services/Database.dart';

class Track_orders extends StatefulWidget {
  const Track_orders({Key? key}) : super(key: key);

  @override
  State<Track_orders> createState() => _Track_ordersState();
}

class _Track_ordersState extends State<Track_orders> {

  final DbRef = FirebaseDatabase(databaseURL: "https://van-lines-default-rtdb.europe-west1.firebasedatabase.app").ref('locations');
 double longituded =38.7448;
 double latituded = 9.0099;
  MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 9.0099, longitude:38.7448),
    areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );



  Future getlocation() async {

    final snapshot_lat = await DbRef.child("latitude").get();
    final snapshot_long = await DbRef.child("longitude").get();
    print(snapshot_long.value);
    print(snapshot_lat.value);
    if (snapshot_lat != null) {
      var y = snapshot_long.value as double ;
     var x = snapshot_lat.value as double;
      setState(() {
         van_loc = [x,y];
        // print("longituded $longituded");
      //   controller = MapController(
      //   initMapWithUserPosition: true,
      //   initPosition: GeoPoint(latitude: y, longitude: x),
      //   areaLimit: BoundingBox(east: 10.4922941,
      //     north: 47.8084648,
      //     south: 45.817995,
      //     west: 5.9559113,),
      // );
    });


      print (controller.initPosition);
       // return [x, y];
  }
  }

  List van_loc = [];
  bool start = true;
  var Route_distance;
  var Route_time;
  double Start_lat = 0;
  double Start_long = 0;
  double Destination_lat = 0;
  double Destination_long = 0;
  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      getlocation();
    });


    final user = Provider.of<UserFB?>(context);
     DatabaseService databaseservice = DatabaseService(uid: user!.uid);
     Future order_locs() async{
     var x = await databaseservice.getOrderlocations();
     print(x);
     setState((){
       Start_lat = x[0];
       Start_long = x[1];
       Destination_lat = x[2];
       Destination_long = x[3];
     });
     }
     Future locatons() async{

       // List x = await getlocation() as List;
         if(start)  {
           await  order_locs();
        await controller.addMarker(
            GeoPoint(latitude: Start_lat, longitude: Start_long),
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 56,
              ),
            ));
        await controller.addMarker(
            GeoPoint(latitude: Destination_lat, longitude: Destination_long),
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 56,
              ),
            ));
        setState(() => start = false);
      }
         Future.delayed(Duration(seconds: 5), () async{
           await controller.changeLocation(GeoPoint(latitude: await van_loc[0], longitude: await van_loc[1]));
         });

     }
     locatons();

    // List x = getlocation() as List;
    // controller.changeLocation(GeoPoint(latitude: 8.99999, longitude: 38.5656));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      title: Text('tracking'),
        // actions: [
        //   FloatingActionButton(onPressed: () async{
        //     order_locs();
        //     await controller.changeLocation(GeoPoint(latitude:Destination_lat, longitude: Destination_long));
        //
        // })],
      ),
      body: Scaffold(
        body: OSMFlutter(
              controller: controller,
              trackMyPosition: false,
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
                  ),
                ),
                directionArrowMarker: MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 48,
                  ),
                ),
              ),
              roadConfiguration: RoadConfiguration(
                startIcon: MarkerIcon(
                  icon: Icon(
                    Icons.person,
                    size: 64,
                    color: Colors.brown,
                  ),
                ),
                roadColor: Colors.yellowAccent,
              ),
              markerOption: MarkerOption(
                  defaultMarker: MarkerIcon(
                    icon: Icon(
                      Icons.car_crash_outlined,
                      color: Colors.blue,
                      size: 56,
                    ),
                  )
              ),
            ),
      ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Details'),
        backgroundColor: Colors.grey,
        onPressed: () async {

      Future drawmultipleroads() async {
        // final int i = 20;
        final configs = [
          MultiRoadConfiguration(
              startPoint: GeoPoint(
                latitude: van_loc[0],
                longitude: van_loc[1],
              ),
              destinationPoint: GeoPoint(
                latitude: Destination_lat + 0.00000000001,
                longitude: Destination_long + 0.000000000001,
              ),
              roadOptionConfiguration: MultiRoadOption(
                roadColor: Colors.orange,

              )
          ),
        ];
        final listRoadInfo = await controller.drawMultipleRoad(
            configs,
            commonRoadOption: MultiRoadOption(
              roadColor: Colors.red,
              roadType: RoadType.car,)
        );
        print(listRoadInfo);
        setState(() {
          Route_distance = listRoadInfo[0].distance;
          Route_time = listRoadInfo[0].duration;
          // Config_route[1]= listRoadInfo[1];
          // Config_route[2]= listRoadInfo[2];
        });
        print(Route_distance);
        // print (Config_route[1]);
        // print (Config_route[2]);
      }
     await drawmultipleroads();
      var minutes = Route_time/60;
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => build_detail(minutes)
      );
    })

    //   await  order_locs();
         //      // List x = await getlocation() as List;
         //    await controller.addMarker(GeoPoint(latitude: Start_lat, longitude: Start_long),markerIcon:MarkerIcon(
         //      icon: Icon(
         //        Icons.location_on,
         //        color: Colors.red,
         //        size: 56,
         //      ),
         //    ));
         //    await controller.addMarker(GeoPoint(latitude: Destination_lat, longitude: Destination_long),markerIcon:MarkerIcon(
         //      icon: Icon(
         //        Icons.location_on,
         //        color: Colors.red,
         //        size: 56,
         //      ),
         //    ));
         //      await controller.changeLocation(GeoPoint(latitude: await van_loc[0], longitude: await van_loc[1]));
         // })
            // mapController.initPosition = ;
          // })

      // ),
    );
  }

  Widget build_detail( double minutes) {
    String min = minutes.toString().substring(0,1) ;
    String Dis = Route_distance.toString().substring(0,5);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Center(child: RichText(
          text: TextSpan(children: [
            TextSpan(text: 'The package will arive in:',style: TextStyle(color: Colors.black, fontSize: 18)),
            TextSpan(text:' $min', style: (TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold))),
            TextSpan(text: ' minutes\n',style: TextStyle(color: Colors.black, fontSize: 18)),
            TextSpan(text: 'Distance is:',style: TextStyle(color: Colors.black, fontSize: 18)),
            TextSpan(text: ' $Dis ', style: (TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold))),
            TextSpan(text: 'Km',style: TextStyle(color: Colors.black, fontSize: 18)),

          ]
          )),),
    );
  }

}

