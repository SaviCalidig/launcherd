import 'package:flutter/cupertino.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';


class googleapps extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _googleapps();
  }
}
class _googleapps extends State<googleapps>{
  @override
  void initState() {
    DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
        onlyAppsWithLaunchIntent: false);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text("Shortcuts"),
            ),

            body: SafeArea(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SafeArea(
                      child: Padding(padding: EdgeInsets.only(left: 30,top: 30),
                        child: InkWell(child: Text("Maps",style: TextStyle(fontSize: 30),), onTap: (){
                          DeviceApps.openApp('com.google.android.apps.maps');
                        }),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,top: 30),
                      child: InkWell(child: Text("Gmail",style: TextStyle(fontSize: 30),), onTap: (){
                        DeviceApps.openApp('com.google.android.gm');
                      }),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30,top: 30),
                      child: InkWell(child: Text("Contacts",style: TextStyle(fontSize: 30),), onTap: (){
                        DeviceApps.openApp('com.google.android.dialer');
                        DeviceApps.openApp('com.android.contacts');
                      }),
                    ),

                    Padding(padding: EdgeInsets.only(left: 30,top: 30),
                      child: InkWell(child: Text("Music",style: TextStyle(fontSize: 30),), onTap: (){
                        DeviceApps.openApp('com.google.android.music');
                      }),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30,top: 30),
                      child: InkWell(child: Text("Message",style: TextStyle(fontSize: 30),), onTap: (){
                        DeviceApps.openApp('com.google.android.apps.messaging');
                      }),
                    ),


                    SizedBox(
                      height: 80,
                    )
                  ],
                )
            )
        )
    );

  }
}
