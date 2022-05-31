import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final databaseReference = FirebaseDatabase.instance.reference();
  Map db = {};
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Temperature Error"),
          content: new Text(
              "The default Temperature is less than or equal to the current temperature"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getData() async {
    try {
      await databaseReference.once().then((DataSnapshot snapshot) {
        db = snapshot.value;
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateData(context, temperatureDestination, location,
      defaultTemperature, currentTemperature) async {
    try {
      if (temperatureDestination == 0 &&
          location.toString().isNotEmpty &&
          defaultTemperature == 0) {
        await databaseReference.update({'location': location});
        print('saved');
      } else if (temperatureDestination == 0 &&
          location.toString().isEmpty &&
          defaultTemperature != 0) {
        await databaseReference
            .update({'defaultTemperature': defaultTemperature});
        print('saved');
      } else if (temperatureDestination != 0 &&
          location.toString().isEmpty &&
          defaultTemperature == 0) {
        if (temperatureDestination > currentTemperature) {
          await databaseReference.update({
            'temperatureDestination': temperatureDestination,
            'onStatus': 1
          });
          print('saved');
        } else {
          await databaseReference.update({'onStatus': 0});
          _showDialog(context);
        }
      } else if (temperatureDestination == 0 &&
          location.toString().isEmpty &&
          defaultTemperature == 0) {
        await databaseReference.update({'onStatus': 0});
        print('saved');
      }
    } catch (e) {
      print(e.toString());
      print('couldnt update');
    }
  }

  Stream<Event> get dbdata {
    return databaseReference.onValue;
  }
}
