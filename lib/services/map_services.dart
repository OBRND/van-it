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

    initPositionPoint = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest);
    print("This is your current Position:: " + initPositionPoint.toString());
    String x = initPositionPoint.toString();

    GeoPoint initPos = GeoPoint(
        latitude: initPositionPoint.latitude,
        longitude: initPositionPoint.longitude);

    initPosition = initPos;

    services s = services();
    s.ful = initPos.latitude;
    s.gul = initPos.longitude;

    print(fu);
    print(gu);

  }

  Future select(double lattitude, double longgitude) async {
    print(lattitude);
    print(longgitude);
    services n = services();
    n.fl = lattitude;
    n.gl = longgitude;
    print(f);
    print(g);
  }
  // });}
  Future calculate() async {
    print('$gu,$fu, $g, $f');
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
    ];
    final listRoadInfo = await controller.drawMultipleRoad(
        configs,
        commonRoadOption: MultiRoadOption(
          roadColor: Colors.red,
          roadType: RoadType.car,)
    );
    var x = listRoadInfo[0];
    print('what the fuck- $x');

    return listRoadInfo[0];
  }
  // drawmultipleroads ();
}