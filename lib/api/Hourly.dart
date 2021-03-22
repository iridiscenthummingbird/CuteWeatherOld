import 'Weather.dart';

class Hourly {
  int _dt;
  int get dt => _dt;
  double _temp;
  double get temp => _temp;
  double _feels_like;
  double get feels_like => _feels_like;
  int _pressure;
  int get pressure => _pressure;
  int _humidity;
  int get humidity => _humidity;
  Weather _weather;
  Weather get weather => _weather;

  Hourly(this._dt, this._temp, this._feels_like, this._pressure, this._humidity,
      this._weather);

  Hourly.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _temp = double.parse(json['temp'].toString());
    _feels_like = double.parse(json['feels_like'].toString());
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    var tmp = json['weather'];
    var weatherJson = tmp[0];
    _weather = Weather.fromJson(weatherJson);
  }
}
