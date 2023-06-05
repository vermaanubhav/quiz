import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/main.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});





  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), (){

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Container(
            height:2000,
            width: 2000,
            child: Image.asset('assets/images/background_image.png')))
    );
  }
}
