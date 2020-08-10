import 'package:flutter/material.dart';
import 'package:launcher/Todo_Tasks/database_helper.dart';

class todoui extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<todoui> {
  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();

  bool validated = true;
  String errtext = "";
  String todoedited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>();

  void addtodo() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: todoedited,
    };
    final id = await dbhelper.insert(row);
    print(id);

    todoedited = "";
    setState(() {
      validated = true;
      errtext = "";
    });
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
//            leading: Checkbox(value: null, onChanged: null),

            title: Text(
              row['todo'],
              style: TextStyle(
                fontSize: 18.0,

              ),
            ),
            trailing: IconButton(icon: Icon(Icons.clear),onPressed: (){
              dbhelper.deletedata(row['id']);
              setState(() {});
            },),


          ),
        ),
      ));
    });
    return Future.value(true);
  }



  @override

  Widget build(BuildContext context) {
    return Material(

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          centerTitle: true,
          
          title: Text(
            "My Tasks",
            style: TextStyle(

              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: Column(
          children: <Widget>[
            TextField(

              controller: texteditingcontroller,
              autofocus: true,
              onChanged: (_val) {
                todoedited = _val;
              },
              style: TextStyle(
                fontSize: 18.0,

              ),
              decoration: InputDecoration(
                hintText: "Add Tasks to do",
                errorText: validated ? null : errtext,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {

                      if (texteditingcontroller.text.isEmpty) {
                        setState(() {
                          errtext = "Can't Be Empty";
                          validated = false;
                        });
                      } else if (texteditingcontroller.text.length >
                          512) {
                        setState(() {
                          errtext = "Too may Chanracters";
                          validated = false;
                        });
                      } else {
                        texteditingcontroller.text = "";
                        addtodo();
                      }
                    },
                    color: Colors.transparent,
                    child: Text("ADD",
                        style: TextStyle(
                          fontSize: 18.0,

                        )),
                  )
                ],
              ),
            ),
           Flexible(
             child: FutureBuilder(
              builder: (context, snap) {
                if (snap.hasData == null) {
                  return Center(
                    child: Text(
                      "No Data",
                    ),
                  );
                } else {
                  if (myitems.length == 0) {
                    return Scaffold(


                      backgroundColor: Colors.transparent,
                      body: Center(
                        child: Text(
                          "No Task Avaliable",
                          style: TextStyle( fontSize: 20.0),
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      body: SingleChildScrollView(
                        child: Column(
                          children: children,
                        ),
                      ),
                    );
                  }
                }
              },
              future: query(),
          ),
           ),
          ],),
      ),
    );
  }
}