import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:heatapp/services/DatabaseService.dart';
import 'package:heatapp/shared/Defaults.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Map data={};
  Map db={};
  DatabaseService base = DatabaseService();
  Defaults d=Defaults();
  _save(location) async {
    await d.saveDefaultTemperature(location, context, '/wrapper',0);
  }
  int currentStrength=0;
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    data=data['data'];
    db=data['db'];
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TouchableOpacity(
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(db['location']??data['location'],
                      style: TextStyle(
                          fontSize: 24
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context,'/clist');
                },
              ),
              Divider(height: 50,thickness: 1,),
              Text('Specify Default Temperature',
              style: TextStyle(
                fontFamily: 'BreeSerif',
                fontSize: 18
              ),
              ),
              SizedBox(height: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Slider(
                    value:currentStrength!=0?currentStrength.toDouble():
                    (db['defaultTemperature']??data['defaultTemperature']??100).toDouble(),
                    min: 10,
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.orange[100],
                    max: 100,
                    onChanged: (val){
                      setState(() {
                        currentStrength=val.round();
                      });
                    },
                    divisions: 80,
                  ),
                  Text((currentStrength!=0?currentStrength:db['defaultTemperature']??data['defaultTemperature']).toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'BreeSerif'
                  ),
                  ),
                  SizedBox(height: 30,),
                  RaisedButton.icon(
                    onPressed: () async {
                      _save(currentStrength);
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.deepOrangeAccent,
                    ),
                    label: Text(
                      'Enter',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                    color: Colors.black,
                  ),
                ],
              ),


            ],
          ),
        ),
      );
  }
}
