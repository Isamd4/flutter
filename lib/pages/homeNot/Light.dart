import 'package:flutter/material.dart';
class Light extends StatelessWidget {
  @override
  Map db;
  Light({this.db});
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
           Text('There is no Light At Home',
             style: TextStyle(
                 fontFamily: 'BreeSerif',
                 fontSize: 20,
                 color: Colors.deepOrange
             ),
           ),
           SizedBox(height: 20,),
           Icon(Icons.lightbulb_outline,size: 100,),
         ],
        ),
      ),
    );
  }
}
