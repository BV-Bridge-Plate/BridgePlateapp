import 'package:bridgeplate/pages/qrimage.dart';
import 'package:bridgeplate/pages/qrscanner.dart';
import 'package:flutter/material.dart';

class QRCode extends StatefulWidget {
  const QRCode({super.key});

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(11, 18, 46, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
         children: [
    Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(child: Text('Content goes here')),
      ),
    ),
    Container(
      //flex: 1,
      child: ElevatedButton(onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QRScanner()));}, child: const Text('Scan')),
    )
            
          ],
        ),
        );
  }
}
