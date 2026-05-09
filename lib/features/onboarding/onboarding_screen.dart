import 'package:flutter/material.dart';
import 'package:news_app/features/onboarding/models/onboarding_models.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: OnboardingModels.onboardingList.length,
        itemBuilder: (context, index) {
          final model = OnboardingModels.onboardingList[index];
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          );
        },
      ),
    );
  }
}
