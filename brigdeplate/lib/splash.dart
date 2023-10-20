import 'package:bridgeplate/pages/starting/Landing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



//import 'package:firebase_core/firebase_core.dart';




class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navToNextPage();
  }

  Future<void> navToNextPage() async {
    const delay = Duration(seconds: 5);
    await Future.delayed(delay);
    Navigator.of(context).pushReplacement(_createRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Center(
        // Using SpinKitDancingSquare for the loader animation
        child: SpinKitDancingSquare(
          color: Colors.blue,
          size: 100.0,
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: Duration(seconds: 2),
    pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin =
          Offset(1.0, 0.0); // Start position (off-screen to the right)
      const end = Offset.zero; // End position (current screen position)
      const curve = Curves.easeInOut; // You can use any curve you like
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  void initState() {
    super.initState();
    navToCardListScreen();
  }

  Future<void> navToCardListScreen() async {
    const delay = Duration(seconds: 5);
    await Future.delayed(delay);
    Navigator.of(context).pushReplacement(_createRoute2());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(11, 18, 46, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'asset/images/Logo.svg',
              width: 100.0,
              height: 100.0,
            ),
           // const Text('bridge plate'),
          ],
        ),
      ),
    );
  }
}

Route _createRoute2() {
  return PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) =>LandingPage (),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin =
          Offset(1.0, 1.0); // Start position (off-screen to the right)
      const end = Offset.zero; // End position (current screen position)
      const curve = Curves.easeInOut; // You can use any curve you like
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
