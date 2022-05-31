import 'package:weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class WeatherState{
  String key='aded2d4d5960423797b12d6739596aaf';
  String city;
  double celsius;
  DateTime date;
  String weatherIcon;
  String time;
  String weatherMain;
  Icon wIcon;
  WeatherState(String city){
    this.city=city;
  }
  Future<void> getWeather() async{
    try{
    WeatherFactory wf=await WeatherFactory(key);
    Weather w= await wf.currentWeatherByCityName(city);
    celsius=w.temperature.celsius;
    DateTime datetime=w.date;
    datetime=datetime.add(Duration(minutes:0));
    time = DateFormat.jm().format(datetime);
    }
    catch(e){
      print('couldnt load weather');
      print(e);
    }
  }
}