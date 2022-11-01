import 'package:flutter/material.dart';

import 'Home.dart';

void main(){
  runApp(MaterialApp(
     title: "News app",
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    home: Home(),
  ));
}


