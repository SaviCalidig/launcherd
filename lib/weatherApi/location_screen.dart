import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:launcher/Changeables/fontSize.dart';
import 'package:launcher/Todo_Tasks/todo.dart';
import 'package:launcher/screens/Settings.dart';
import 'package:launcher/weatherApi/WeatherModel.dart';
import 'package:launcher/weatherApi/loading_screen.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  double size;
  int temperature;
  String weatherIcon;
  String Currenttime;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 30), (Timer t) => getTime());
    DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
        onlyAppsWithLaunchIntent: false);
    loading_screen();
    getLocationData();
    getTime();
    getFontSize();

    updateUI(widget.locationWeather);
  }
  getFontSize(){
    double i=20;
    setState(() {
     i=fontsize().getlargefontsize(i) ;
    size=i;
    });
    return i;

  }
  getTime(){
    DateTime now = DateTime.now();
    if(this.mounted){

      setState(() {
        String convertedDateTime = " ${now.hour.toString()}:${now.minute.toString()}";
        Currenttime=convertedDateTime;
      });
    }

   

    return Text("$Currenttime",style: TextStyle(fontSize:size),);

  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';

        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getTime(),
              




              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      weatherIcon,
                    ),
                  ],
                ),
              ),
              Flexible(child: Divider(height: 200,)),
              Padding(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                child: InkWell(
                    child: Text(
                      "Calls",
                      style: TextStyle(fontSize: 30),
                    ),
                    onTap: () {
                      DeviceApps.openApp('com.android.contacts');
                      DeviceApps.openApp('com.google.android.dialer');
                    }),
              ),
              Padding(padding: EdgeInsets.only(top: 20,bottom: 20),
                child: InkWell(
                  child: Text(
                    "Task",
                    style: TextStyle(fontSize: 30),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return todoui();
                    }));
                  },
                ),
              ),
              Flexible(
                child: IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return settings();
                      }));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    updateUI(weatherData);

//    Navigator.push(context, MaterialPageRoute(builder: (context) {
//      return LocationScreen(
//        locationWeather: weatherData,
//      );
//    }));
  }
}
