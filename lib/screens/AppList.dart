

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppList();
  }
}

class _AppList extends State<AppList> {
  var search;
  var compare;


  @override
  void initState() {
    super.initState();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body:
           Stack(
             children: <Widget>[
               Positioned(top: 5,right: 5,child:  SafeArea(
                 child: InkWell(
                   child: Text('Settings',style: TextStyle(fontSize: 15),),
                 ),
               )),

              Flexible(

                   child: gwtApplist()
               )
             ],
           ),


          );

  }
}
class gwtApplist extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _getApps();
  }
}
class _getApps extends State<gwtApplist>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return FutureBuilder(


       future: DeviceApps.getInstalledApplications(
           includeAppIcons: true,
           includeSystemApps: true,
           onlyAppsWithLaunchIntent: false),
       builder: (context, data) {
         if (data.data == null) {
           return Center(
             child: Text('loading'),
           );
         } else {

           List<Application> appList = data.data;
           return SingleChildScrollView(

               child: Column(
                 children: <Widget>[
                   ListView.builder(



                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemCount: appList.length,
                       itemBuilder: (BuildContext context, int index) {
                         List<Application> appList = data.data;
                         Application app = appList[index];

                         return Column(
                           children: <Widget>[
                             Container(
                                 color: Colors.transparent,
                                 child: ListTile(
                                     leading: app is ApplicationWithIcon
                                         ? CircleAvatar(
                                       backgroundImage:
                                       MemoryImage(app.icon),
                                       backgroundColor: Colors.white,
                                     )
                                         : null,
                                     title: Text(
                                       app.appName,
                                       overflow: TextOverflow.ellipsis,
                                       style: TextStyle(color: Colors.black),
                                     ),
                                     subtitle: Text(app.versionName,
                                         overflow: TextOverflow.ellipsis,
                                         style:
                                         TextStyle(color: Colors.black)),
                                     onTap: () {
                                       DeviceApps.openApp(app.packageName);
                                       print(app.packageName);
                                     }))
                           ],
                         );
                       }),
                   SizedBox(
                     height: 80,
                   )
                 ],
               ));
         }
       });
  }
}