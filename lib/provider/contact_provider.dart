import 'package:flutter/foundation.dart';

class ContactProvider with ChangeNotifier {
  int stepIndex = 0;

  void nextStep() {
    if (stepIndex < 3) {
      stepIndex++;
    }
    notifyListeners();
  }

  void cancelStep() {
    if (stepIndex > 0) {
      stepIndex--;
    }
    notifyListeners();
  }
}
