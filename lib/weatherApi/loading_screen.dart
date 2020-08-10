import 'package:flutter/material.dart';
import 'package:launcher/weatherApi/WeatherModel.dart';
import 'package:launcher/weatherApi/location_screen.dart';

class loading_screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loading_screen();
  }
}
class _loading_screen extends State<loading_screen>{
  void initState(){
    super.initState();

    getLocationData();
  }
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Colors.white30,

    );
  }
}