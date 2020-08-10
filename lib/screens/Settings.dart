import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:launcher/screens/ThemeBuilder.dart';

class settings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _settings();
  }
}
class _settings extends State<settings>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: false,
        onlyAppsWithLaunchIntent: false);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title:Text("Settings"),
        ),

        body: SafeArea(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(
                height: 15,
              ),
              InkWell(
                onTap: (){
                  DeviceApps.openApp('com.android.settings');
                },
                child: Text("System Settings",style: TextStyle(fontSize: 25),),
              ),
              Divider(thickness: 4,
                height: 45,
              ),
              InkWell(
                child: Text('Themes',style: TextStyle(fontSize: 25),),
                onTap: (){
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            height: 100,
                            color: Colors.transparent,
                            child: Center(
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("Change Theme "),
                                      subtitle: Text("Tap here to Change Theme" ),
                                      trailing: Icon(Icons.home),onTap: (){


                                      ThemeBuilder.of(context).changeTheme();
                                      setState(() {
                                        ThemeBuilder.of(context).getCurrentTheme();
                                      });
                                    },

                                    ),
                                    Divider(
                                      height: 2,
                                    ),


                                  ],

                                )));});
                },

              ),
              Divider(thickness: 4,
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }

}