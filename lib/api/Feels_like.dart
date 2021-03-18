class Feels_like {
  double _day;
  double _night;
  double _eve;
  double _morn;
  Feels_like(this._day, this._night, this._eve, this._morn);
  Feels_like.fromJson(Map<String, dynamic> json) {
    _day = json['day'];
    _night = json['night'];
    _eve = json['eve'];
    _morn = json['morn'];
  }
}
