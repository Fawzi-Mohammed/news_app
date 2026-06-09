import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app/features/onboarding/models/onboarding_models.dart';
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
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Builder(
        builder: (context) {
          final onboardingCubit = context.read<OnboardingCubit>();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF5F5F5),
              actions: [
                BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    return state.isLastPage
                        ? SizedBox.shrink()
                        : TextButton(
                            onPressed: () async {
                              await _onFinish(context);
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(fontSize: AppSizes.sp16),
                            ),
                          );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.pw16,
                vertical: AppSizes.ph30,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: onboardingCubit.pageController,
                      onPageChanged: onboardingCubit.onPageChange,
                      itemCount: OnboardingModels.onboardingList.length,
                      itemBuilder: (context, index) {
                        final model = OnboardingModels.onboardingList[index];
                        return SafeArea(
                          child: Column(
                            children: [
                              Image.asset(model.image, width: double.infinity),
                              SizedBox(height: AppSizes.ph24),
                              Text(
                                model.title,
                                style: TextStyle(
                                  fontSize: AppSizes.sp20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4E4B66),
                                ),
                              ),
                              SizedBox(height: AppSizes.ph12),
                              Text(
                                model.description,
                                style: TextStyle(
                                  fontSize: AppSizes.sp12,
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
                  SizedBox(height: AppSizes.ph24),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return SmoothPageIndicator(
                        controller: onboardingCubit.pageController,
                        count: OnboardingModels.onboardingList.length,
                        effect: SwapEffect(
                          activeDotColor: Color(0xFFC53030),
                          dotColor: Color(0xFFD3D3D3),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppSizes.ph112),
                  SizedBox(
                    height: AppSizes.h52,
                    width: double.infinity,
                    child: BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (!state.isLastPage) {
                              await onboardingCubit.pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.decelerate,
                              );
                            } else {
                              await _onFinish(context);
                            }
                          },
                          child: Text(
                            state.isLastPage ? 'Get Started' : 'Next',
                          ),
                        );
                      },
                    ),
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
