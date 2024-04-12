import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qube/res/string.dart';
import 'package:qube/view/home_page.dart';
import 'package:qube/view/index_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const IndexPage())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/qube_logo.png", height: 108, width: 108),
            const SizedBox(height: 5),
            const Text(logoName,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
