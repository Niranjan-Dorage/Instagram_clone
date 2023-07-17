import 'package:flutter/foundation.dart';

class Redlikeprovider with ChangeNotifier {
  bool pressed = true;
  void clicked() {
    if (pressed) {
      pressed = false;
    } else {
      pressed = true;
    }
    notifyListeners();
  }
}
