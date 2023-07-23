import 'package:flutter/foundation.dart';

class Postupload with ChangeNotifier {
  String imageurl = "";
  bool pressed = true;
  void clicked(imagelink) {
    imageurl = imagelink;
    notifyListeners();
  }
}
