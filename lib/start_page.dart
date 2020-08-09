import 'dart:async';
import 'dart:math';

import 'package:Lottery/home_page.dart';
import 'package:Lottery/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bingo_normal.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _pulseAnimation;
  bool result = false;
  Future<bool> isNotFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("loginVegas");
  }
  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    _pulseAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _animationController.reverse();
      else if (status == AnimationStatus.dismissed)
        _animationController.forward();
    });
    _animationController.forward();
    isNotFirstTime().then((value) {
      if(value!=null)
          { result = value;}
          else
          result = false;
              
         });
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
         return  result?HomePage():Login_page();
        
      })),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c1863),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(//mainAxisAlignment: MainAxisAlignment.s,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Positioned(
            top: 100,
            // left: MediaQuery.of(context).size.width*0.39,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 3),
              curve: Curves.easeIn,
              height: 150,
              width: 150,
              child: ScaleTransition(
                scale: _pulseAnimation,
                child: Center(
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
