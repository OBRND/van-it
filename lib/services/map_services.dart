import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';

class services{
// bool i = false;

  static double fu =0;
  static double gu=0;
  static double f=0;
  static double g=0;
  List user_position = [services.fu,
    services.gu];
  set ful(double value) => fu= value;
  set gul(double value) => gu= value;
  set fl(double value) => f= value;
  set gl(double value) => g= value;
// Marker marker;
  MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 9.0099, longitude:38.7448),
    areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );


  Future locatePosition() async {

    Position initPositionPoint;
    GeoPoint initPosition;

// if (
// i == false) {
    initPositionPoint = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("This is your current Position:: " + initPositionPoint.toString());
    String x = initPositionPoint.toString();

    GeoPoint initPos = GeoPoint(
        latitude: initPositionPoint.latitude,
        longitude: initPositionPoint.longitude);

    initPosition = initPos;

// String y = initPositionPoint.toString().substring(10,19);
// String z = initPositionPoint.toString().substring(32,42);
// print(y);
// print(z);
// var long1 = double.parse('$y');
// var long2 = double.parse('$z');
    services s = services();
    s.ful = initPos.latitude;
    s.gul = initPos.longitude;
// final String h = "$fu $gu";
    print(fu);
    print(gu);
// print(h);

// i == true;
// return h;
// }
  }

  Future select(double lattitude, double longgitude) async {
    print(lattitude);
    print(longgitude);
    services n = services();
    n.fl = lattitude;
    n.gl = longgitude;
    // final String k = "$f $g";
    print(f);
    print(g);
    // print(k);
    // return k;
    //   });
  }
  // });}
  Future calculate() async {
    print('$gu,$fu, $g, $f');
    // double distanceInMeters = Geolocator.distanceBetween(
    //       services.gu,services.fu,services.g,services.f);
    // print("$distanceInMeters meters");
    double distanceEnMetres = await distance2point(
        GeoPoint(longitude: services.gu,latitude: services.fu,),
        GeoPoint( longitude: services.g, latitude: services.f ));
    print("$distanceEnMetres meters");

  }
  Future drawmultipleroads () async {
    // final int i = 20;
    final configs = [
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: f,
          longitude: g,
        ),
        destinationPoint: GeoPoint(
          latitude: fu,
          longitude: gu,
        ),
    roadOptionConfiguration: MultiRoadOption(
          roadColor: Colors.orange,
      roadWidth: 15,
        )),
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
    var x = listRoadInfo[0];
    print('what the fuck- $x');

    // print (Config_route[0]);
    // print (Config_route[1]);
    // print (Config_route[2]);
    return listRoadInfo[0];
  }
  // drawmultipleroads ();
}