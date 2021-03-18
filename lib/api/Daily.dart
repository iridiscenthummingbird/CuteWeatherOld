import 'Weather.dart';
import 'Temp.dart';
import 'Feels_like.dart';

class Daily {
  int _dt;
  Temp _temp;
  Feels_like _feels_like;
  int _pressure;
  int _humidity;
  Weather _weather;

  Daily(this._dt, this._temp, this._feels_like, this._pressure, this._humidity,
      this._weather);

  Daily.fromJson(Map<String, dynamic> json) {
    _dt = json['dt'];
    var tempJson = json['temp'];
    _temp = Temp.fromJson(tempJson);
    var feelsLikeJson = json['feels_like'];
    _feels_like = Feels_like.fromJson(feelsLikeJson);
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    var tmp = json['weather'];
    var weatherJson = tmp[0];
    _weather = Weather.fromJson(weatherJson);
  }
}
