import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app2/utils/resource/style.dart';
import 'package:restaurant_app2/screens/home/home_page.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    });

    return Stack(
      children: [
        Container(color: primary),
        const Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.restaurant,
            color: Colors.white,
            size: 80,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
              strokeWidth: 10,
            ),
          ),
        )
      ],
    );
  }
}
