import 'dart:async';

import 'package:covid_19/view/spalsh_scarren.dart';
//import 'package:covid_tracker/View/spalsh_screen.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller =AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Worldscreen();
      }));
    });
  }
  void dispose(){
    super.dispose();
    _controller.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("My Apps"),),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              AnimatedBuilder(
                  child: Container(
                      height: 200,
                      width: 200,
                      child: Center(child: Image(image: AssetImage("images/virus.png"),))),
                  animation: _controller,
                  builder:(BuildContext context,Widget?child){
                    return Transform.rotate(angle:_controller.value*2*math.pi,
                      child:child ,
                    );
                  }),
              SizedBox(height: MediaQuery.of(context).size.height *0.08,),
              Text("Covid-19\n Tracker Apps",textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)

            ],
          ),
        ),
      ),
    );
  }
}
