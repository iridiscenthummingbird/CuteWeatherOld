import 'Weather.dart';

class Hourly {
  int _dt;
  double _temp;
  double _feels_like;
  int _pressure;
  int _humidity;
  Weather _weather;
  Hourly(this._dt, this._temp, this._feels_like, this._pressure, this._humidity,
      this._weather);

  Hourly.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _temp = json['temp'];
    _feels_like = json['feels_like'];
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    var tmp = json['weather'];
    var weatherJson = tmp[0];
    _weather = Weather.fromJson(weatherJson);
  }
}
