import 'Weather.dart';

class Current {
  int _dt;
  double _temp;
  double _feels_like;
  int _pressure;
  Weather _weather;

  Current(
      this._dt, this._temp, this._feels_like, this._pressure, this._weather);
}
