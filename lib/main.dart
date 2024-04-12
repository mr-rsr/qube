import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qube/res/string.dart';
import 'package:qube/view/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: logoName,
      theme: ThemeData(
        textTheme: GoogleFonts.figtreeTextTheme(Theme.of(context).textTheme),
      ),
      home: const SplashPage(),
    );
  }
}
