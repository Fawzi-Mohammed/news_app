import 'package:flutter/material.dart';

mixin SafeNotify on ChangeNotifier {
  bool isDispose = false;
  @override
  dispose() {
    isDispose = true;
    super.dispose();
  }

  void safeNotify() {
    if (!isDispose) notifyListeners();
  }
}
