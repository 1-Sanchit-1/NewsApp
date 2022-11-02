import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home.dart';


void main(){
  runApp(MaterialApp(
     title: "News app",
    debugShowCheckedModeBanner: false,
    theme:  ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
    ),
    // darkTheme: ThemeData.dark(),
    home: Home(),
  ));
}


