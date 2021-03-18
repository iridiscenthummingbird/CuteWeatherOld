class Temp {
  double _day;
  double _min;
  double _max;
  double _night;
  double _eve;
  double _morn;
  Temp(this._day, this._min, this._max, this._night, this._eve, this._morn);
  Temp.fromJson(Map<String, dynamic> json) {
    _day = json['day'];
    _min = json['min'];
    _max = json['max'];
    _night = json['night'];
    _eve = json['eve'];
    _morn = json['morn'];
  }
}
