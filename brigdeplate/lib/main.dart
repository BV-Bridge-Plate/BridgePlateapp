
import 'package:bridgeplate/firebase/firebase_options.dart';
import 'package:bridgeplate/pages/donationAd.dart';
import 'package:bridgeplate/pages/starting/Landing.dart';
import 'package:bridgeplate/pages/starting/Phone.dart';
import 'package:bridgeplate/pages/starting/choice.dart';
import 'package:bridgeplate/pages/starting/doneeReg.dart';
import 'package:bridgeplate/pages/starting/donorReg.dart';
import 'package:bridgeplate/pages/starting/verify.dart';
import 'package:bridgeplate/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = 'splash';

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      initialRoute = 'choice';
    }
  } catch (e) {
    print(e);
    // You can set an error route here or handle this differently
    // initialRoute = 'error';
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      routes: {
        'splash': (context) => Splash(),
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify(),
        'landing': (context) => LandingPage(),
        'choice': (context) => DonorDoneeChoice(),
        'Donee': (context) => DoneeRegistration(),
        'Donor': (context) => DonorRegistration(),
         //'Donorr': (context) => 
        'Doneee': (context) => CardListScreen(),
        // Add an error page route if you like
        // 'error': (context) => ErrorPage(),
      },
    );
  }
}