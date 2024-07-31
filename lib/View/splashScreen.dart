// ignore_for_file: prefer_const_constructors, annotate_overrides

import 'dart:async';

import 'package:covid_19_app/word_status.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WorldStatus()),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            child: Container(
              height: 200,
              width: 200,
              child: Image(
                image: AssetImage('images/virus.png'),
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * 2.0 * math.pi,
                child: child,
              );
            },
          ),
          SizedBox(
            height: 100,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Covid-19\nTracker App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
