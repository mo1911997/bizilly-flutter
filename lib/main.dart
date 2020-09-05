import 'package:flutter/material.dart';
import 'package:VeViRe/Screens/SplashScreen.dart';
import 'package:VeViRe/utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yellow Pages',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Raleway'),
      home: SplashScreen(),
    );
  }
}
