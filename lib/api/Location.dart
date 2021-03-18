import 'Current.dart';
import 'Hourly.dart';
import 'Daily.dart';

class Location {
  double _lat;
  double _lon;
  String _timezone;
  int _timezone_offset;
  Current _current;
  List<Hourly> _hourly;
  List<Daily> _daily;

  Location(this._lat, this._lon, this._timezone, this._timezone_offset,
      this._current);
}
