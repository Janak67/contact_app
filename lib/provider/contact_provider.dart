import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:share_plus/share_plus.dart';
import '../model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  int stepIndex = 0;
  String? path;
  int? infoIndex;
  bool isPrivate = false;
  bool isLock = false;

  List<ContactModel> contactList = [];
  List<ContactModel> hideContactList = [];

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

  void updateImagePath(String? newpath) {
    path = newpath;
    notifyListeners();
  }

  void addContact(ContactModel cm) {
    contactList.add(cm);
    notifyListeners();
  }

  void clean() {
    stepIndex = 0;
    notifyListeners();
  }

  void deleteContact() {
    if (isLock) {
      hideContactList.removeAt(infoIndex!);
    } else {
      contactList.removeAt(infoIndex!);
    }

    notifyListeners();
  }

  void editContact(ContactModel c1) {
    if (isLock) {
      hideContactList[infoIndex!] = c1;
    } else {
      contactList[infoIndex!] = c1;
    }
    notifyListeners();
  }

  void storeIndex(int index) {
    infoIndex = index;
    notifyListeners();
  }

  Future<void> shareData(ContactModel c1) async {
    Share.share("${c1.name}\n ${c1.contact}");
    ShareResult result = await Share.shareWithResult("");
  }

  void hideContact() {
    ContactModel hiddenContact = contactList[infoIndex!];
    hideContactList.add(hiddenContact);
    contactList.removeAt(infoIndex!);
    notifyListeners();
  }
  void unHideContact() {
    ContactModel unHiddenContact = hideContactList[infoIndex!];
    contactList.add(unHiddenContact);
    hideContactList.removeAt(infoIndex!);
    notifyListeners();
  }

  Future<bool?> bioMatrix() async {
    LocalAuthentication auth = LocalAuthentication();
    bool checkBioMatrixStatus = await auth.canCheckBiometrics;
    if (checkBioMatrixStatus) {
      List<BiometricType> bioTypes = await auth.getAvailableBiometrics();
      if (bioTypes.isNotEmpty) {
        bool isLogin = await auth.authenticate(
          localizedReason: 'Please Correct privacy Password',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        return isLogin;
      }
    }
    return null;
  }
}
