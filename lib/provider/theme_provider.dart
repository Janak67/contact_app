import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier
{
  bool islight = false;

  void changeTheme()
  {
    islight = !islight;
    notifyListeners();
  }
}