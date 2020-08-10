import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_appavailability/flutter_appavailability.dart';



class testing extends StatefulWidget {
  @override
  _testingState createState() => new _testingState();
}

class _testingState extends State<testing> {
  String search;
  final searchediting=TextEditingController();

  List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [

  ];


  @override
  void initState() {

    super.initState();
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;

    if (Platform.isAndroid) {

      _installedApps = await AppAvailability.getInstalledApps();



    }
    else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      _installedApps = iOSApps;

      print(await AppAvailability.checkAvailability("calshow://"));
      // Returns: Map<String, String>{app_name: , package_name: calshow://, versionCode: , version_name: }

    }

    setState(() {
      installedApps = _installedApps;
    });

  }

  @override
  Widget build(BuildContext context) {
    if (installedApps == null)
      getApps();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Your Device Apps"),
      ),

      body: Column(children: <Widget>[
        TextField(autofocus: false,onChanged: (val){
          search=val;
        },controller: searchediting,decoration: InputDecoration(
            hintText: "Search device apps",
            prefix: IconButton(icon: Icon(Icons.search), onPressed: (){
              searchediting.clear();


              for(int i=0;i<installedApps.length;i++)
                {

                  if(search.toLowerCase()==installedApps[i]['app_name'].toLowerCase()){
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return ListTile(
                            title: InkWell(child: Text(installedApps[i]["app_name"],style: TextStyle(fontSize: 25),),onTap: (){
//                              Scaffold.of(context).hideCurrentSnackBar();
                              AppAvailability.launchApp(installedApps[i]["package_name"]).then((_) {
                                print("App ${installedApps[i]["app_name"]} launched!");
                              }).catchError((err) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("App ${installedApps[i]["app_name"]} not found!")
                                ));
                                print(err);
                              });

                            },),

                          );

                        });

                  }






            }

              search='';
            })
        ),



        ),

        Flexible(
          child: ListView.builder(
            itemCount: installedApps == null ? 0 : installedApps.length,


            itemBuilder: (context, index) {



              return ListTile(
                title: InkWell(child: Text(installedApps[index]["app_name"],style: TextStyle(fontSize: 25),),onTap: (){
                  Scaffold.of(context).hideCurrentSnackBar();
                  AppAvailability.launchApp(installedApps[index]["package_name"]).then((_) {
                    print("App ${installedApps[index]["app_name"]} launched!");
                  }).catchError((err) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("App ${installedApps[index]["app_name"]} not found!")
                    ));
                    print(err);
                  });

                },),

              );
            },
          ),
        ),
      ]),
    );

  }
}