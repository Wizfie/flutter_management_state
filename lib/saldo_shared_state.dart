import 'package:flutter/material.dart';

class SaldoState with ChangeNotifier {
  int _saldo = 10000;
  final int _reset = 10000;

  int get getSaldo {
    return _saldo;
  }

  int get getReset {
    return _reset;
  }

  void kurangiSaldo(int cost) {
    _saldo -= cost;
    notifyListeners();
  }

  void resetsaldo() {
    _saldo = _reset;
    notifyListeners();
  }
}
