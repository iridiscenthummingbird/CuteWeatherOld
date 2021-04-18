import 'package:cute_weather/api/Weather.dart';

class City {
  double _lat;
  double get lat => _lat;
  double _lon;
  double get lon => _lon;
  int _timezone;
  int get timezone => _timezone;
  Weather _weather;
  Weather get weather => _weather;
  String _name;
  String get name => _name;

  double _temp;
  double get temp => _temp;

  City(this._lat, this._lon, this._name);

  City.fromJson(Map<String, dynamic> json) {
    var tmp = json['coord'];
    _lat = tmp['lat'];
    _lon = tmp['lon'];
    _timezone = json['timezone'];
    _name = json['name'];
    tmp = json['weather'];
    var weatherJson = tmp[0];
    _weather = Weather.fromJson(weatherJson);
    tmp = json['main'];
    _temp = double.parse(tmp['temp'].toString());
  }
}
