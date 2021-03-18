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
}
