import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:van_lines/services/Database.dart';

import '../../../../models/User.dart';


class Qr_Scanner extends StatefulWidget {
  const Qr_Scanner({Key? key}) : super(key: key);

  @override
  State<Qr_Scanner> createState() => _Qr_ScannerState();
}

class _Qr_ScannerState extends State<Qr_Scanner> {

  final qr_key = GlobalKey(debugLabel: 'Qr');
  QRViewController? controller;
  Barcode? Qrcode;

  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();

      controller!.pauseCamera();

      controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
    body: Stack(
      alignment: Alignment.center,
      children: [
        build_Qr_view(context),
        Positioned(bottom: 20, child: build_result()),
      ],

    ))
    );
  }

  Widget build_Qr_view(BuildContext context) => QRView(
      key: qr_key,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width*0.8,
        borderWidth:  10,
        borderLength: 20,
          borderRadius: 10,),
    onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),

  );

  Widget build_result() => Container(
    padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white70
      ),
      child: Text(Qrcode != null ? 'Result: ${Qrcode!.code}':'Scan a code'));

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void onQRViewCreated(QRViewController controller){
    final user = Provider.of<UserFB?>(context);
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((Qrcode) {
      DatabaseService(uid: user!.uid).finishOrder(Qrcode!.code);
      setState(() {
        this.Qrcode = Qrcode;
      });
    });
  }

}
