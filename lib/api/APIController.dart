import 'package:cute_weather/api/City.dart';
import 'Location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'keys.dart';

class APIController {
  static Future<Location> fetchData(City city) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/onecall', {
      'lat': city.lat == null ? '47.8558882' : city.lat.toString(),
      'lon': city.lon == null ? '34.8951733' : city.lon.toString(),
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

  static Future<City> fetchCity(String cityname) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
        {'q': cityname, 'appid': Keys.weatherKey, 'units': 'metric'});
    var response = await http.get(url);
    City city;
    if (response.statusCode == 200) {
      //todo: try catch
      var jsonResponse = convert.jsonDecode(response.body);
      city = City.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return city;
  }
}
