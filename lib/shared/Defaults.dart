import 'package:shared_preferences/shared_preferences.dart';
import 'package:heatapp/services/DatabaseService.dart';
import 'package:flutter/material.dart';
class Defaults{
  SharedPreferences prefs;
  DatabaseService d= DatabaseService();
  String location;
  int defaultTemperature;
  save(location,context,route) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('${location.toString()}', location.toString());
    await d.updateData(context,0,location,0,0);
    Navigator.popUntil(context,ModalRoute.withName('$route'));
  }
  Future<void> getLocation(location) async{
    prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('$location');
    if(stringValue==null){
      this.location='Africa/Lagos';
    }
    else{
      this.location=stringValue;
    }
  }
  saveDefaultTemperature(temperature,context,route,currentTemperature) async{
    prefs=await SharedPreferences.getInstance();
    await prefs.setInt('defaultTemperature', temperature);
    await d.updateData(context,0, '',temperature,currentTemperature);
    Navigator.popUntil(context, ModalRoute.withName('$route'));
  }
  Future<void> getDefaultTemperature(defaultTemperature) async{
    prefs=await SharedPreferences.getInstance();
    int defaultTemp=prefs.getInt('$defaultTemperature');
    this.defaultTemperature=defaultTemp;
  }
}

