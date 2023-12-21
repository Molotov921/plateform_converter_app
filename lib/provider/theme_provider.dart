import 'package:flutter/material.dart';

class ThemeChangeAppProvider extends ChangeNotifier {
  bool isAndroid = false;
  void platFromCheck() {
    isAndroid = !isAndroid;
    notifyListeners();
  }
}
