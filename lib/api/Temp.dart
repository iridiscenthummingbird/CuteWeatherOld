class Temp {
  double _day;
  double get day => _day;
  double _min;
  double get min => _min;
  double _max;
  double get max => _max;
  double _night;
  double get night => _night;
  double _eve;
  double get eve => _eve;
  double _morn;
  double get morn => _morn;
  Temp(this._day, this._min, this._max, this._night, this._eve, this._morn);
  Temp.fromJson(Map<String, dynamic> json) {
    _day = double.parse(json['day'].toString());
    _min = double.parse(json['min'].toString());
    _max = double.parse(json['max'].toString());
    _night = double.parse(json['night'].toString());
    _eve = double.parse(json['eve'].toString());
    _morn = double.parse(json['morn'].toString());
  }
}
