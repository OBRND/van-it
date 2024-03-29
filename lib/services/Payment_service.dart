import 'package:van_lines/shared/Payment_item.dart';
import 'package:van_lines/services/Tarrif_data.dart';
import 'package:van_lines/shared/Payment_tariff.dart';
class Payment{
final Payment_item order;
  Payment({required this.order});

 Calculate() async {
   Tariff _tariff = await getTarif().getTariff();
  Map transport = _tariff.transport;
  Map packaging = _tariff.packaging;
  Map services = _tariff.services;
  late int Total_payment ;
  late int transport_cost ;
  late int service_cost ;
  late int packaging_cost ;

  // print('$transport hehehhehehehehhehehe');
   if (order.Service_type == 1) {
     if(order.Package == 'Small'){                  //for small packages
       Total_payment = transport_cost = (transport['Mini_van'] * order.Distance).round();                       //cost of van use and service provided by van
       if(order.Items.contains('Boxes15'))
         Total_payment += packaging_cost = 15 * packaging['Boxperunit'] as int;             //cost of Cardboard box packaging
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
        Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
      } // for without elevator computation with floor number included
       if(order.has_elevator_destination) {
         service_cost += order.Items.length *  services['loadingWelevator'] as int;
         Total_payment += order.Items.length* services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
        Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
      }

      // for(int i=0; i < order.Items.length; i++) {
       //   Total_payment += ;
       // }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
   else if(order.Package == 'Medium'){                  //for small packages
     Total_payment = transport_cost = (transport['Isuzu'] * order.Distance).round();                      //cost of van transport and service of van cost
     if(order.Items.contains('Boxes30')) {
       Total_payment += packaging_cost = 30*packaging['Boxperunit'] as int;
     }             //cost of Cardboard box packaging
     if(order.has_elevator_pickup) {
       service_cost = order.Items.length * services['loadingWelevator'] * 1.15 + services['Van_service/trip'] as int;     // there is a 15 % increase for loading service in medium packages
       Total_payment += order.Items.length * services['loadingWelevator'] * 1.15 + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
     } else {
       service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] * 1.15 + services['Van_service/trip'] as int;
       Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] * 1.15 + services['Van_service/trip'] as int;
     } // for without elevator computation with floor number included
     if(order.has_elevator_destination) {
       service_cost += order.Items.length * services['loadingWelevator'] * 1.15 as int;
       Total_payment += order.Items.length * services['loadingWelevator'] * 1.15 as int;
     }else {
       service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] * 1.15 as int;
       Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] *1.15 as int;
     }
     Total_payment += (Total_payment*0.15).round();
     service_cost += (Total_payment*0.15).round();
     print('================ $Total_payment ==================== this is the total price');
     List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
     return pay;

   }

   else if(order.Package == 'Large'){                  //for small packages
     Total_payment = transport_cost = (transport['Isuzu FSR'] * order.Distance).round();                      //cost of van transport and service of van cost
     if(order.Items.contains('Boxes30')) {
       Total_payment += packaging_cost = 30 * packaging['Boxperunit'] as int;
     }             //cost of Cardboard box packaging
     if(order.has_elevator_pickup) {
       service_cost = order.Items.length * services['loadingWelevator'] * 1.2 + services['Van_service/trip'] as int;
       Total_payment += order.Items.length * services['loadingWelevator'] * 1.2 + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
     } else {
       service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] * 1.2 + services['Van_service/trip'] as int;
       Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] * 1.2 + services['Van_service/trip'] as int;
     } // for without elevator computation with floor number included
     if(order.has_elevator_destination) {
       service_cost += order.Items.length * services['loadingWelevator'] * 1.2 as int;
       Total_payment += order.Items.length  * services['loadingWelevator'] * 1.2 as int;
     }else {
       service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] * 1.2 as int;
       Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] * 1.2 as int;
     }
     Total_payment += (Total_payment*0.15).round();
     service_cost += (Total_payment*0.15).round();
     print('================ $Total_payment ==================== this is the total price');
     List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
     return pay;
   }

   else if(order.Package == 'Huge'){                  //for small packages
     Total_payment = transport_cost = (transport['Iveco'] * order.Distance).round();                      //cost of van transport and service of van cost
     if(order.Items.contains('Boxes99')) {
       Total_payment += packaging_cost = 30 * packaging['Boxperunit'] as int;
     }             //cost of Cardboard box packaging
     if(order.has_elevator_pickup) {
       service_cost = order.Items.length * services['loadingWelevator'] * 1.3 + services['Van_service/trip'] as int;
       Total_payment += order.Items.length * services['loadingWelevator'] * 1.3 + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
     } else {
       service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] * 1.3.round() + services['Van_service/trip'] as int;
       Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] * 1.3.round() + services['Van_service/trip'] as int;
     } // for without elevator computation with floor number included
     if(order.has_elevator_destination) {
       service_cost += order.Items.length  * services['loadingWelevator'] * 1.3 .round() as int;
       Total_payment += order.Items.length * services['loadingWelevator'] * 1.3 .round() as int;
     }else {
       service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] * 1.3 as int;
       Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] * 1.3 as int;
     }
     Total_payment += (Total_payment*0.15).round();
     service_cost += (Total_payment*0.15).round();
     print('================ $Total_payment ==================== this is the total price');
     List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
     return pay;
   }

   }
   else if(order.Service_type == 2) {
     if(order.Package == 'Small'){
       Total_payment = transport_cost = (transport['Mini_van'] * order.Distance *1.5).round();
       Total_payment += packaging_cost = 15 * packaging['Boxperunit'] as int;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
     if(order.Package == 'Medium'){
       Total_payment = transport_cost = (transport['Isuzu'] * order.Distance *1.5).round();
       Total_payment += packaging_cost = 30 * packaging['Boxperunit'] as int;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
     if(order.Package == 'Large'){
       Total_payment = transport_cost = (transport['Isuzu FSR'] * order.Distance *1.5).round();
       Total_payment += packaging_cost = 50 * packaging['Boxperunit'] as int;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
     if(order.Package == 'Huge'){
       Total_payment = transport_cost = (transport['Iveco'] * order.Distance *1.5).round();
       Total_payment += packaging_cost = 99 * packaging['Boxperunit'] as int;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
   }
   else if(order.Service_type == 3) {
     print(order.Package);
     if(order.Package == 'Mini van'){
       Total_payment = transport_cost = (transport['Mini_van'] * order.Distance).round();
       Total_payment += packaging_cost = 0 * packaging['Boxperunit'] as int;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
     if(order.Package == 'Isuzu'){
       Total_payment = transport_cost = (transport['Isuzu'] * order.Distance ).round();
       Total_payment += packaging_cost = 0;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
     if(order.Package == 'Isuzu FSR'){
       Total_payment = transport_cost = (transport['Isuzu FSR'] * order.Distance).round();
       Total_payment += packaging_cost = 0;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
   }else if(order.Service_type == 4) {
     print(order.Package);
     if(order.Package == 'Special wrapping'){
       Total_payment = transport_cost = (transport['Mini_van'] * order.Distance).round();
       Total_payment += packaging_cost = int.parse(order.Items[0]) * packaging['Specialpackaging'] as int;
       if(order.has_elevator_pickup) {
         service_cost = (int.parse(order.Items[0])/5).round()  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += (int.parse(order.Items[0])/5).round() * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = (int.parse(order.Items[0])/5).round() * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += (int.parse(order.Items[0])/5).round() * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += (int.parse(order.Items[0])/5).round() * services['loadingWelevator'] as int;
         Total_payment += (int.parse(order.Items[0])/5).round() * services['loadingWelevator'] as int;
       }else {
         service_cost += (int.parse(order.Items[0])/5).round() * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += (int.parse(order.Items[0])/5).round() * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
     if(order.Package == 'Refrigeration'){
       Total_payment = transport_cost = (transport['RefrigerationVan'] * order.Distance ).round();
       Total_payment += packaging_cost = 0;
       if(order.has_elevator_pickup) {
         service_cost = order.Items.length  * services['loadingWelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] + services['Van_service/trip'] as int;                //for with elevator computation with floor numbers included
       } else {
         service_cost = order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
         Total_payment += order.Items.length * order.Floor_pickup * services['loadingWoutelevator'] + services['Van_service/trip'] as int;
       }
       if(order.has_elevator_destination) {
         service_cost += order.Items.length * services['loadingWelevator'] as int;
         Total_payment += order.Items.length * services['loadingWelevator'] as int;
       }else {
         service_cost += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
         Total_payment += order.Items.length * order.Floor_destination * services['loadingWoutelevator'] as int;
       }
       Total_payment += (Total_payment*0.15).round();
       service_cost += (Total_payment*0.15).round();
       print('================ $Total_payment ==================== this is the total price');
       List pay = [Total_payment, transport_cost, service_cost, packaging_cost];
       return pay;
     }
   }
   else return [0,0,0,0];
 }

}