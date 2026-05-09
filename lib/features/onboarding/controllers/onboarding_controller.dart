import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  int currentIndex = 0;
  final PageController pageController = PageController();
  bool isLastPage = false;
  void onPageChange(int index) {
    currentIndex = index;
    if (currentIndex == 2) {
      isLastPage = true;
    } else {
      isLastPage = false;
    }
    notifyListeners();
  }
}
