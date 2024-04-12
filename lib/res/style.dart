import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(FontWeight fontWeight, double size, {Color? color}) =>
    GoogleFonts.figtree(
      fontSize: size,
      fontWeight: fontWeight,
      color: color ?? const Color(0xfffafafa),
    );
