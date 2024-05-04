import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  static final StreamController<void> _controller =
      StreamController<void>.broadcast();

  static Stream<void> get personalInformationStream => _controller.stream;

  static Future<bool> editPersonalInformation(String? newName) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      bool changed = false;
      if (newName != null && newName != currentUser.displayName) {
        await currentUser.updateDisplayName(newName);
        changed = true;
      }
      if (changed) {
        _controller.add(null);
      }
      return changed;
    }
    return false;
  }

  static void dispose() {
    _controller.close();
  }
}
