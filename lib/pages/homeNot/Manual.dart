import 'package:flutter/material.dart';
class Manual extends StatelessWidget {
  @override
  Map db;
  Manual({this.db});
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
        children: [
          SizedBox(height: 20,),
          Text('Current Temperature',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'BreeSerif',
            ),
          ),
          SizedBox(height: 3,),
          Text('${db['currentTemperature']}C',
            style: TextStyle(
                fontSize: 50,
                fontFamily: 'BreeSerif',
                color: Colors.deepOrange, fontWeight: FontWeight.bold
            ),
          ),
          Divider(height: 50,),
          Text('The System is in Manual mode...Please go and change it'
              ' to Automatic  ',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'BreeSerif',
                color: Colors.deepOrange
            ),
          ),
        ],
        ),
      ),
    );
  }
}
