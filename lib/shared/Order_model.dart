class order_model{
  final String Order_status;
  final String Order_ID;
  final List Items;
  final bool has_elevator_pickup;
  final bool has_elevator_destination;
  final int Floor_pickup;
  final int Floor_destination;
  final String Payment_status;
  final int Payment;
  // final double Distance;
  final String Pickupdate;
  order_model({
    required this.Pickupdate,
    required this.Order_status,
    required this.Order_ID,
    required this.Items,
    required this.has_elevator_pickup,
    required this.has_elevator_destination,
    required this.Floor_pickup,
    required this.Floor_destination,
    required this.Payment_status,
    required this.Payment,
    // required this.Distance
  });
}