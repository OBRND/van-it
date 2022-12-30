import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_lines/shared/Payment_tariff.dart';

class getTarif {

  final CollectionReference Tariffs = FirebaseFirestore.instance.collection('Tariff');

  Future getTariff() async {
    // FirebaseFirestore _instance= FirebaseFirestore.instance;
    DocumentSnapshot tariff = await Tariffs.doc('Tariff').get();
    Map transport = tariff['Transport'];
    Map packaging = tariff['Packaging'];
    Map service = tariff['Service'];

    print(transport);
    print(packaging);
    print(service);
    Tariff Tarif = Tariff(transport: transport, packaging: packaging, services: service);

    return Tarif;
  }
}