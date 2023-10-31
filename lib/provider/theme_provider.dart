import 'package:contact_app/utils/share_helper.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  bool islight = false;

  void changeTheme() async{
    ShareHelper shr = ShareHelper();
    bool? isTheme = await shr.getTheme();
    islight = isTheme ?? false;
    notifyListeners();
  }
}
