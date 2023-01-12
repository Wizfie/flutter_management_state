import 'package:flutter/material.dart';

class KeranjangState with ChangeNotifier {
  int _qty = 0;

  int get getQty {
    return _qty;
  }

  void tambahkeranjang() {
    _qty++;
    notifyListeners();
  }

  void kurangikeranjang() {
    _qty--;
    notifyListeners();
  }
}
