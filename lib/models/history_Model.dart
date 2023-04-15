class history_Model{
  final String Order_status;
  final String Order_ID;
  final List Items;
  final bool has_elevator_pickup;
  final bool has_elevator_destination;
  final int Floor_pickup;
  final int Floor_destination;
  final int Payment;
  // final double Distance;
  DateTime Pickupdate;
  history_Model({
  required this.Pickupdate,
  required this.Order_status,
  required this.Order_ID,
  required this.Items,
  required this.has_elevator_pickup,
  required this.has_elevator_destination,
  required this.Floor_pickup,
  required this.Floor_destination,
  required this.Payment,
  // required this.Distance
  });
}