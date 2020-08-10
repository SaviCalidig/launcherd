import 'package:flutter/material.dart';

import 'package:launcher/screens/ThemeBuilder.dart';

import 'package:launcher/screens/googleApps.dart';
import 'package:launcher/screens/tsting.dart';


import 'package:launcher/weatherApi/location_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  PageController pageController;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
//      defaultBrightness: Brightness.light,
      builder: (context, _brightness) {
        return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.blue, brightness: _brightness),
            debugShowCheckedModeBanner: false,
            home: Scaffold(

              body: PageView(
                controller: pageController,
                pageSnapping: true,
                children: <Widget>[



                  LocationScreen(),
                  testing(),




                  googleapps(),

                ],
              ),
            ));
      },
    );
  }
}
