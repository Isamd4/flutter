import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:heatapp/services/DatabaseService.dart';

class Temperature extends StatefulWidget {
  @override
  _TemperatureState createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  @override
  int spinner = 0;
  DatabaseService base = DatabaseService();
  Map data={};
  _save(spinner,currentTemperature) async {
    try {
      base.updateData(context,spinner,'',0,currentTemperature);
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    if(spinner<=data['currentTemperature'].toInt()){
      spinner=data['currentTemperature'].toInt();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Specify Temperature',
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
                  value: (spinner??100).toDouble(),
                  min: 0,
                  activeColor: Colors.deepOrange,
                  inactiveColor: Colors.orange[100],
                  max: 100,
                  onChanged: (val){
                    setState(() {
                      spinner=val.round();
                    });
                  },
                  divisions: 80,
                ),
                Text(spinner.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'BreeSerif'
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            RaisedButton.icon(
              onPressed: () async {
                _save(spinner,data['currentTemperature']);
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
            Divider(height: 70,thickness: 1,),
            TouchableOpacity(
              child: CircleAvatar(
                radius: 80,
                child: Text(
                  'MAX',
                  style:
                      TextStyle(fontSize: 30, color: Colors.deepOrangeAccent),
                ),
                backgroundColor: Colors.black,
              ),
              onTap: () {
                setState(() {
                  spinner = 100;
                });
                _save(spinner,data['currentTemperature']);
              },
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
