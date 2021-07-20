import 'package:flutter/material.dart';
import 'package:smart_learning/images.dart';
import 'package:smart_learning/screens/article/newsletter_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.forward();

    _controller.addListener(() {
      setState(() {
        if (_controller.isCompleted) {
          Navigator.pushReplacementNamed(context, NewsletterScreen.id);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Opacity(
          opacity: _controller.value,
          child: Container(
            child: Image.asset(LocalImages.imgBrain),
            width: 170.0,
            height: 170.0,
          ),
        ),
      ),
    );
  }
}
