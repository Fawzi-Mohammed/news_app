import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/controllers/onboarding_controller.dart';
import 'package:news_app/features/onboarding/models/onboarding_models.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _onFinish(BuildContext context) async {
    await PreferenceManger().setBool('onboarding_complete', true);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingController>(
      create: (context) => OnboardingController(),
      builder: (context, child) {
        final onboardingController = context.read<OnboardingController>();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFF5F5F5),
            actions: [
              Consumer<OnboardingController>(
                builder: (context, OnboardingController value, child) {
                  return onboardingController.isLastPage
                      ? SizedBox.shrink()
                      : TextButton(
                          onPressed: () async {
                            await _onFinish(context);
                          },
                          child: Text('Skip'),
                        );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: onboardingController.pageController,
                    onPageChanged: (index) {
                      onboardingController.onPageChange(index);
                    },
                    itemCount: OnboardingModels.onboardingList.length,
                    itemBuilder: (context, index) {
                      final model = OnboardingModels.onboardingList[index];
                      return SafeArea(
                        child: Column(
                          children: [
                            Image.asset(model.image, width: double.infinity),
                            SizedBox(height: 24),
                            Text(
                              model.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4E4B66),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              model.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6E7191),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 24),
                Consumer<OnboardingController>(
                  builder: (context, OnboardingController value, child) {
                    return SmoothPageIndicator(
                      controller: value.pageController,
                      count: OnboardingModels.onboardingList.length,
                      effect: SwapEffect(
                        activeDotColor: Color(0xFFC53030),
                        dotColor: Color(0xFFD3D3D3),
                      ),
                    );
                  },
                ),
                SizedBox(height: 114),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: Consumer<OnboardingController>(
                    builder: (context, OnboardingController value, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (!value.isLastPage) {
                            onboardingController.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.decelerate,
                            );
                          } else {
                            await _onFinish(context);
                          }
                        },
                        child: Text(value.isLastPage ? 'Get Started' : 'Next'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
