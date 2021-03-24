import 'Weather.dart';

class Current {
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
  double _wind_deg;
  double get wind_deg => _wind_deg;
  double _wind_speed;
  double get wind_speed => _wind_speed;
  double _dew_point;
  double get dew_point => _wind_speed;
  double _uvi;
  double get uvi => _uvi;
  double _clouds;
  double get clouds => _clouds;
  double _visibility;
  double get visibility => _visibility;

  Current(this._dt, this._temp, this._feels_like, this._pressure,
      this._humidity, this._weather);

  Current.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    _temp = double.parse(json['temp'].toString());
    _feels_like = double.parse(json['feels_like'].toString());
    _wind_deg = double.parse(json['wind_deg'].toString());
    _wind_speed = double.parse(json['wind_speed'].toString());
    _dew_point = double.parse(json['dew_point'].toString());
    _uvi = double.parse(json['uvi'].toString());
    _clouds = double.parse(json['clouds'].toString());
    _visibility = double.parse(json['visibility'].toString());
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    var tmp = json['weather'];
    var weatherJson = tmp[0];
    _weather = Weather.fromJson(weatherJson);
  }
}
