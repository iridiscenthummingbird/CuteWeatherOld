class Feels_like {
  double _day;
  double get day => _day;
  double _night;
  double get night => _night;
  double _eve;
  double get eve => _eve;
  double _morn;
  double get morn => _morn;
  Feels_like(this._day, this._night, this._eve, this._morn);
  Feels_like.fromJson(Map<String, dynamic> json) {
    _day = double.parse(json['day'].toString());
    _night = double.parse(json['night'].toString());
    _eve = double.parse(json['eve'].toString());
    _morn = double.parse(json['morn'].toString());
  }
}
