import 'package:flutter/material.dart';
import 'package:heatapp/pages/home/Home.dart';
import 'package:provider/provider.dart';
import 'package:heatapp/services/DatabaseService.dart';
import 'package:firebase_database/firebase_database.dart';
class Wrapper extends StatelessWidget {
  @override
  Map data={};
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    return StreamProvider<Event>.value(
      value: DatabaseService().dbdata,
      child: Home(data),
    );
  }
}
