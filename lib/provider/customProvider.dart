import 'package:flutter/foundation.dart';
import 'package:cute_weather/api/APIController.dart';
import 'package:cute_weather/api/Location.dart';

class CustomProvider with ChangeNotifier {
  Location _loc;
  Location get location => _loc;

  Future<void> getData() async {
    _loc = await APIController.fetchData();
    notifyListeners();
  }
}
