import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:heatapp/shared/Defaults.dart';
class CList extends StatefulWidget {
  @override
  _CListState createState() => _CListState();
}

class _CListState extends State<CList> {
  @override
  Defaults d=Defaults();
  _save(location) async {
    await d.save(location, context, '/wrapper');
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Locations"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: FutureBuilder(
                future: DefaultAssetBundle
                    .of(context)
                    .loadString('assets/country.json'),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var new_data = json.decode(snapshot.data.toString());

                  return ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: TouchableOpacity(
                          onTap: (){_save(new_data[index].toString());},
                          child: ListTile(
                            title: Text(new_data[index]),
                            onTap: (){
                              _save(new_data[index].toString());
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: new_data == null ? 0 : new_data.length,
                  );
                }),
          ),
        ));
  }
}