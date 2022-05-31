import 'package:flutter/material.dart';
import 'package:heatapp/pages/home/FirstColumn.dart';
import 'package:heatapp/pages/home/SecondColumn.dart';
import 'package:heatapp/pages/homeNot/Light.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:heatapp/services/DatabaseService.dart';
import 'package:heatapp/pages/homeNot/Manual.dart';
import 'package:fswitch/fswitch.dart';
class Home extends StatefulWidget {
  Map data;
  Home(Map data) {
    this.data = data;
  }
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Color colorSwitch = Colors.white54;
  Color switchColor = Colors.black54;
  bool status = false;
  Map db = {};
  Map data = {};
  int onStatus = 0;
  double textOnSize = 30;
  double lightOnSize = 50;
  DatabaseService base = DatabaseService();
  Widget build(BuildContext context) {
    data = widget.data;
    final cloudData = Provider.of<Event>(context);
    if (cloudData != null) {
      data['db'] = cloudData.snapshot.value;
      db = data['db'];
      data['defaultTemperature'] = db['defaultTemperature'];
    } else {
      db = data['db'];
    }
    onStatus = db['onStatus'];
    status=(onStatus!=0)?true:false??status;
    if(status==false){
      colorSwitch = Colors.white54;
      switchColor = Colors.black54;
      textOnSize = 30;
      lightOnSize = 50;
    }
    else{
      colorSwitch = Colors.deepOrange;
      switchColor = Colors.deepOrange;
      textOnSize = 40;
      lightOnSize = 60;
    }
    if(db['manual']){
      return Manual(db: db,);
    }
    else if(db['powerStatus']==0){
      return Light(db: db);
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FirstColumn(
                    data,  status),
                SecondColumn(data, !status),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 25, 390),
          child: FSwitch(
            width: 125.0,
            height: 55.0,
            open: status,
            openColor:Colors.deepOrange ,
            offset: 5.0,
            closeChild: Text(
              "Off",
              style: TextStyle(
                  color: Colors.white, fontSize: 25),
            ),
            openChild: Text(
              "On",
              style: TextStyle(
                  color: Colors.white, fontSize: 25),
            ),
            onChanged: (val) async{
              if (val == false) {
                await base.updateData(context, 0, '', 0, db['currentTemperature']);
                setState(() {
                  status = val;
                });
              } else {
                await  base.updateData(context, db['defaultTemperature'], '', 0, db['currentTemperature']);
                setState(() {
                  status = val;
                });
              }
            },
          ),
        ),
      );
    }
  }
}
