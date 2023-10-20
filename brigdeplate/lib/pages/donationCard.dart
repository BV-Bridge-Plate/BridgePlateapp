import 'dart:convert';
import 'dart:typed_data';

import 'package:bridgeplate/dbhelper/details.dart';
import 'package:bridgeplate/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DonationCard extends StatefulWidget {
  final String id;
  DonationCard({required this.id});

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  Map<String, dynamic>? details;
  Map<String, dynamic>? dondetails;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchdetails();
    fetchdonationdetails();
  }

  Future<void> fetchdetails() async {
    try {
      details = await DetailService.fetchDetailsByUserId(widget.id);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchdonationdetails() async {
    try {
      dondetails = await DetailService.fetchDonationDetailsByUserId(widget.id);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextStyle _headerStyle = TextStyle(
    color: Colors.black26,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 2.0,
    wordSpacing: 4.0,
    shadows: [
      Shadow(
        color: Colors.grey,
        offset: Offset(2.0, 2.0),
        blurRadius: 2.0,
      ),
    ],
  );

  MemoryImage? base64ToImage(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    Uint8List bytes = base64Decode(base64String);
    return MemoryImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: SpinKitDancingSquare(
          color: Colors.blue,
          size: 100.0,),);
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(details?['userid'] ?? 'User'),
      ),
      body: Column(
        children: [
          _buildSection(details?['name'], Color.fromARGB(227, 176, 223, 166),
              ElevatedButton(onPressed: () {}, child: const Text('Donate'))),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapPage(
                      lat: dondetails?['lat'] ?? 0.0,
                      long: dondetails?['long'] ?? 0.0),
                ));
              },
              child: const Text('Map')),
        ],
      ),
    );
  }

  Widget _buildSection(String? header, Color bgColor, [Widget? child]) {
    return Container(
      color: bgColor,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(header ?? 'Default Header',
                textAlign: TextAlign.left, style: _headerStyle),
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height *
                (child == null ? 0.3 : 0.4),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white70,
            ),
            child: child != null
                ? Center(
                    child: Column(
                    children: [
                      Text("description:${dondetails?['desc'] ?? 'No description'}"),
                      Text("units:${dondetails?['qty'] ?? '0'}"),
                      child,
                    ],
                  ))
                : null,
          ),
          if (base64ToImage(details?['photo']) != null)
            Container(
              height: 150,
              width: 150,
              child: Image(image: base64ToImage(details?['photo'])!),
            ),
        ],
      ),
    );
  }
}
