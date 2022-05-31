import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:heatapp/services/WorldTime.dart';
import 'package:heatapp/services/DatabaseService.dart';
import 'package:heatapp/shared/Defaults.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Defaults d= Defaults();
  WorldTime lagos=WorldTime('Lagos','Africa/Lagos','Nigeria.png');
  DatabaseService base=DatabaseService();
  void setupWorldTime() async{
    await d.getLocation('location');
    await d.getDefaultTemperature('defaultTemperature');
    String location=d.location;
    if(location.isNotEmpty){
      List l=location.toString().split('/');
      String city=l[1].toString();
      lagos=WorldTime(city, location, 'uk.png');
    }
    else{
      lagos=WorldTime('Lagos','Africa/Lagos','uk.png');
    }
    await lagos.getTime();
    await base.getData();
    Navigator.pushReplacementNamed(context, '/wrapper',arguments:{
      'time':lagos.time,
      'location':lagos.location,
      'flag':lagos.flag,
      'isDaytime':lagos.isDaytime,
      'db':base.db,
      'defaultTemperature':d.defaultTemperature
    } );
  }
  @override
  void initState(){
    setupWorldTime();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
          body:SpinKitFadingCube(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.deepOrange : Colors.black,
                ),
              );
            },
          )
    );
  }
}
