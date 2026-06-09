import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/onboarding/models/onboarding_models.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  final PageController pageController = PageController();

  void onPageChange(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
        isLastPage: index == OnboardingModels.onboardingList.length - 1,
      ),
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
