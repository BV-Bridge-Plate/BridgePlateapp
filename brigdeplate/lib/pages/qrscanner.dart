import 'dart:io';
import 'package:bridgeplate/dbhelper/details.dart';
//import 'package:bridgeplate/dbhelper/sendNotification.dart';
import 'package:bridgeplate/pages/qrcode.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

//doner app
class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  Map<String, dynamic>? donee;
  String? errorMessage;
  bool isverified = false;
  Future<void> fetchdonee( String? result) async {
    try {
      donee = await DetailService.fetchDetailsByUserPhone(result!);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
     setState(() {
        isverified = true;
         if (isverified) {
              //  sendNotifications();
            }
      });
    }
  }
 
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
  Future<void> toQrCode() async {
    const delay = Duration(seconds: 4);
    await Future.delayed(delay);
     Navigator.of(context).pushReplacement(_createRoute());;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 5,
          child: QRView(
            key: qrkey,
            onQRViewCreated: onQRViewCamera,
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                 (result != null)
                ? Text('Data:${result!.code}')
                : Text('Scan a code'),
                (isverified == true)
                ? Text("Transaction completed with ${donee?['name']}", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),)
                : Text('') ,
      ],),),
        )
      ],
    ));
  }

  void onQRViewCamera(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        fetchdonee(result!.code);
      });
    });
  }
}

Route _createRoute() {
  return PageRouteBuilder(
  transitionDuration: Duration(seconds: 1), 
    pageBuilder: (context, animation, secondaryAnimation) => QRCode(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, -1.0);  // Start position (off-screen to the right)
      const end = Offset.zero;  // End position (current screen position)
      const curve = Curves.easeInOut;  // You can use any curve you like
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}