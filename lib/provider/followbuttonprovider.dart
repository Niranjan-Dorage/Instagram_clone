import 'package:flutter/foundation.dart';

// class Followbuttonprovider with ChangeNotifier {
//   bool followed = false;
//   void clicked() {
//     if (followed == false) {
//       followed = true;
//     } else {
//       followed = false;
//     }

//     notifyListeners();
//   }
// }
class Followbuttonprovider with ChangeNotifier {
  Map<String, bool> _followStatus = {};

  bool isFollowed(String userId) {
    return _followStatus.containsKey(userId) && _followStatus[userId]!;
  }

  void follow(String userId) {
    if (!_followStatus.containsKey(userId)) {
      _followStatus[userId] = true;
      notifyListeners();
    }
  }

  void unfollow(String userId) {
    if (_followStatus.containsKey(userId)) {
      _followStatus.remove(userId);
      notifyListeners();
    }
  }
}
