import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
class SecondColumn extends StatefulWidget {
  bool isButtonEnabled;
  Map data;
  SecondColumn(Map data,bool isButtonEnabled){
    this.isButtonEnabled=isButtonEnabled;
    this.data=data;
  }

  @override
  _SecondColumnState createState() => _SecondColumnState();
}

class _SecondColumnState extends State<SecondColumn> {
  @override
  Map db={};
  bool status=false;
  Color switchColor = Colors.black54;
  double textOnSize = 30;
  Widget build(BuildContext context) {
    db=widget.data['db'];
    status=widget.isButtonEnabled;
    print(db['onStatus']);
    if(status==true){
      switchColor = Colors.black54;
      textOnSize = 30;
    }
    else{
      switchColor = Colors.deepOrange;
      textOnSize = 40;
    }
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white60,
        child: Column(
          children: <Widget>[
            Text('TEMP',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'BreeSerif',

              ),
            ),
            SizedBox(height: 7,),
            Text('${db['currentTemperature']}C',
              style: TextStyle(
                  fontSize: textOnSize,
                  fontFamily: 'BreeSerif',
                  color: switchColor, fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 440,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  child: IconButton(
                    icon: Icon(MaterialCommunityIcons.home_thermometer,color:  (db['onStatus']==0?Colors.deepOrange:Colors.black54)??(db['onStatus']==0?Colors.deepOrange:Colors.black54),),
                    onPressed: (){
                    if(status){
                      Navigator.pushNamed(context, '/temperature',arguments: {
                        'currentTemperature':db['currentTemperature']
                      });
                    }
                    },
                    iconSize: 40,
                  ),
                )
                ,
                Align(
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: (){
                      if(status){
                        Navigator.pushNamed(context, '/settings',arguments: {
                          'data':widget.data
                        });
                      }
                    },
                    tooltip: 'settings',
                    iconSize: 40,
                    color:(db['onStatus']==0?Colors.deepOrange:Colors.black54)??(db['onStatus']==0?Colors.deepOrange:Colors.black54),
                  ),
                  alignment: Alignment(0.9,0),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
