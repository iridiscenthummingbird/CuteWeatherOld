import 'Location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class APIController {
  static String _key = "61448bd85ce69993353c26e7d1cbd6e0";

  static Future<Location> fetchData() async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/onecall',
        {'lat': '51.0276', 'lon': '4.4807', 'appid': _key, 'units': 'metric'});
    var response = await http.get(url);
    Location data;
    if (response.statusCode == 200) {
      //try {
      var jsonResponse = convert.jsonDecode(response.body);
      data = Location.fromJson(jsonResponse);
      // } catch (e) {
      //   print(e);
      // }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return data;
  }
}
