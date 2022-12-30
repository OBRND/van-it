class Payment_item{
  final int Service_type;
  final String Package;
  final List Items;
  final bool has_elevator_pickup;
  final bool has_elevator_destination;
  final int Floor_pickup;
  final int Floor_destination;
  final double Distance;
Payment_item({
    required this.Service_type,
    required this.Package,
    required this.Items,
    required this.has_elevator_pickup,
    required this.has_elevator_destination,
    required this.Floor_pickup,
    required this.Floor_destination,
    required this.Distance
});

}
class Locations{
  final List start;
  final List destination;

  Locations({
    required this.start,
    required this.destination
});
}