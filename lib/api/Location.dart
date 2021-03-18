import 'Current.dart';
import 'Hourly.dart';
import 'Daily.dart';

class Location {
  double _lat;
  double get lat => _lat;
  double _lon;
  String _timezone;
  int _timezone_offset;
  Current _current;
  List<Hourly> _hourly;
  List<Daily> _daily;

  Location(this._lat, this._lon, this._timezone, this._timezone_offset,
      this._current);

  Location.fromJson(Map<String, dynamic> json) {
    _lat = json['lat'];
    _lon = json['lon'];
    _timezone = json['timezone'];
    _timezone_offset = json['timezone_offset'];
    var currentJson = json['current'];
    _current = Current.fromJson(currentJson);
    var hourlyJson = json['hourly'];
    _hourly = [];
    for (var hJson in hourlyJson) {
      _hourly.add(Hourly.fromJson(hJson));
    }
    var dailyJson = json['daily'];
    _daily = [];
    for (var dJson in dailyJson) {
      _daily.add(Daily.fromJson(dJson));
    }
  }
}
