import 'package:flutter/foundation.dart';

class Profileupload with ChangeNotifier {
  String imageurl = "";
  void clicked(imagelink) {
    imageurl = imagelink;
    notifyListeners();
  }
}
