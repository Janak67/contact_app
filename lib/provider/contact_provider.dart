import 'package:flutter/foundation.dart';

import '../model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  int stepIndex = 0;
  String? imagepath;
  String? path;

  List<ContactModel> contactList = [];

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

  void updateImagePath(String newpath){
    path = newpath;
    notifyListeners();
  }

  void addContact(ContactModel cm) {
    contactList.add(cm);
    notifyListeners();
  }
}
