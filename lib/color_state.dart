import 'package:flutter/material.dart';

class ColorState with ChangeNotifier {
  bool _isOrange = false;

  bool get getIsOrange {
    return _isOrange;
  }

  Color get getColors {
    return _isOrange ? Colors.orange : Colors.blue;
  }

  set setColors(bool value) {
    _isOrange = value;
    notifyListeners();
  }
}
