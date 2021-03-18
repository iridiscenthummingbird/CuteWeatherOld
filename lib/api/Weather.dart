class Weather {
  int _id;
  String _main;
  String _description;
  String _icon;

  Weather(this._id, this._main, this._description, this._icon);

  //Weather.fromJson(Map<String, dynamic> json) {
  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }
}
