import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: lightTheme,
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
