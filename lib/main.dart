import 'package:flutter/material.dart';

import 'pages/Loading.dart';
import 'pages/home/Settings.dart';
import 'pages/Wrapper.dart';
import 'pages/home/CList.dart';
import 'pages/home/Temperature.dart';
void main() => runApp(MaterialApp(
 initialRoute:'/' ,
 routes: {
  '/':(context)=>Loading(),
  '/wrapper':(context)=>Wrapper(),
  '/settings':(context)=>Settings(),
  '/clist':(context)=>CList(),
  '/temperature':(context)=>Temperature()
 },
));


