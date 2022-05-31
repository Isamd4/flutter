import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String time;
  String location;
  String url;
  String flag = 'uk.png';
  bool isDaytime;
  WorldTime(String location, String url, String flag) {
    this.location = location;
    this.url = url;
    this.flag = flag;
  }
  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];
      int offset = int.parse(data['utc_offset'].toString().substring(1, 3));
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: offset));
      time = DateFormat.jm().format(now);
      isDaytime = now.hour < 20 && now.hour > 6 ? true : false;
    } catch (e) {
      print(e);
      print('couldnt fetch');
    }
  }
}
