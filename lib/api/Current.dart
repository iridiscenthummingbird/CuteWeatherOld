import 'Weather.dart';

class Current {
  int _dt;
  double _temp;
  double _feels_like;
  int _pressure;
  Weather _weather;

  Current(
      this._dt, this._temp, this._feels_like, this._pressure, this._weather);

  Current.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _temp = json['temp'];
    _feels_like = json['feels_like'];
    _pressure = json['pressure'];
    var tmp = json['weather'];
    var weatherJson = tmp[0];
    _weather = Weather.fromJson(weatherJson);
  }
}
