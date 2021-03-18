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
}
