import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navAfterSplash();
  }

  void _navAfterSplash() async {
    await Future.delayed(Duration(seconds: 1));
    final onboardingComplete =
        PreferenceManger().getBool('onboarding_complete') ?? false;
    final isLoggedIn = PreferenceManger().getBool('is_logged_in') ?? false;
    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnboardingScreen();
          },
        ),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
