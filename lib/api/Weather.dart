class Weather {
  int _id;
  int get id => _id;
  String _main;
  String get main => _main;
  String _description;
  String get description => _description;
  String _icon;
  String get icon => _icon;

  Weather(this._id, this._main, this._description, this._icon);

  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }
}
