import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class FirstColumn extends StatefulWidget {
  @override
  Map data;
  bool status;
  FirstColumn (Map data,bool status){
    this.data=data;
    this.status=status;
  }

  @override
  _FirstColumnState createState() => _FirstColumnState();
}

class _FirstColumnState extends State<FirstColumn> {
  Map db={};
  double cBar=0;
  bool status=false;
  double textOnSize = 30;
  double lightOnSize = 50;
  Color colorSwitch = Colors.white54;
  Widget build(BuildContext context) {
  db=widget.data['db'];
  cBar= 100*db['currentTemperature']/(db['temperatureDestination']>db['currentTemperature']?db['temperatureDestination']:100);
  List l=(db['location']??widget.data['location']).toString().split('/');
  String city=l[1].toString();
  status=widget.status;
  if(status==false){
    colorSwitch = Colors.white54;
    textOnSize = 30;
    lightOnSize = 50;
  }
  else{
    colorSwitch = Colors.deepOrange;
    textOnSize = 40;
    lightOnSize = 60;
  }
    return  Expanded(
      flex: 1,
      child: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.flash_on,
                color: db['powerStatus']!=0?Colors.amber:Colors.white,
                size: lightOnSize,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(city,
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 2,
                        color: Colors.white54,
                        fontFamily: 'BreeSerif'
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(widget.data['time'],
                style: TextStyle(
                    fontSize: 45,
                    color: Colors.white54,
                  fontFamily: 'BreeSerif'
                ),
              ),
              SizedBox(height: 220,),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: status?cBar.round()/100:0,
                center: new Text(
                  "${status?cBar.round():0}%",
                  style:
                  new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0,fontFamily: 'BreeSerif',color: colorSwitch),
                ),
                footer: new Text(
                  "Temperature Progress",
                  style:
                  new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0,fontFamily: 'BreeSerif',color: colorSwitch),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: colorSwitch,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
