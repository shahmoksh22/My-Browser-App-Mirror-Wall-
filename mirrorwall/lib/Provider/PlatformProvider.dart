import 'package:flutter/material.dart';

class PlatformProvider extends ChangeNotifier {
  bool isandroid = false;
  void changeplatform() {
    isandroid = !isandroid;
    notifyListeners();
  }
}
