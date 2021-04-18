import 'package:cute_weather/api/City.dart';
import 'package:flutter/foundation.dart';
import 'package:cute_weather/api/APIController.dart';
import 'package:cute_weather/api/Location.dart';

class CustomProvider with ChangeNotifier {
  Location _loc;
  Location get location => _loc;

  City _city;
  City get city => _city;

  void setCity(City cit) {
    _city = cit;
    _loc.name = _city.name;
  }

  Future<void> getData() async {
    if (_city == null) {
      _city = City(47.8558882, 34.8951733, "Zaporizhzhia");
    }
    _loc = await APIController.fetchData(_city);
    notifyListeners();
  }

  Future<void> getCity(String name) async {
    _city = await APIController.fetchCity(name);
    notifyListeners();
  }
}
