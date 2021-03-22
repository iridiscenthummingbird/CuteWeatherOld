import 'Location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'keys.dart';

class APIController {
  static Future<Location> fetchData() async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/onecall', {
      'lat': '47.8558882',
      'lon': '34.8951733',
      'appid': Keys.weatherKey,
      'units': 'metric'
    });
    var response = await http.get(url);
    Location data;
    if (response.statusCode == 200) {
      //todo: try catch
      var jsonResponse = convert.jsonDecode(response.body);
      data = Location.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return data;
  }
}
