import 'dart:async';
import './profile_screen.dart';
import '../login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  bool val = false;
  navigationPage() {
    val
        ? Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName)
        : Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    checkIsLogin();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  Future<Null> checkIsLogin() async {
    String _token = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token");
    if (_token != "" && _token != null) {
      setState(() {
        val = true;
      });
      print("splash login.");
    } else {
      print('splash logout');
      val = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF2143FF),
            Color(0xFF001381),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Padding(padding: EdgeInsets.only(bottom: 30.0),child:new Image.asset('lib/assets/blankprofile.png',height: 50.0,fit: BoxFit.scaleDown,))
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                    'assets/images/splash.jpeg',
                    width: animation.value * 150,
                    height: animation.value * 200,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
