import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/features/auth/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthState());
  AuthRepo authRepo;

  final TextEditingController userName = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> login({
    required String userName,
    required String password,
  }) async {
    try {
      emit(
        state.copyWith(status: RequestStatusEnum.loading, errorMessage: null),
      );
      final userModel = await authRepo.login(
        userName: userName,
        password: password,
      );
      if (userModel != null) {
        emit(
          state.copyWith(
            user: userModel,
            status: RequestStatusEnum.loaded,
            errorMessage: null,
          ),
        );
        await PreferenceManger().setBool('is_logged_in', true);
      } else {
        emit(
          state.copyWith(
            status: RequestStatusEnum.error,
            errorMessage: 'Login failed. Please check your credentials.',
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatusEnum.loading, errorMessage: null));

    await Future.delayed(const Duration(seconds: 3));

    final error = await UserRepository().signUp(
      name: name,
      email: email,
      password: password,
    );

    if (error != null) {
      emit(
        state.copyWith(status: RequestStatusEnum.error, errorMessage: error),
      );
      return;
    }

    await PreferenceManger().setBool('is_logged_in', true);

    emit(state.copyWith(status: RequestStatusEnum.loaded, errorMessage: null));
  }

  @override
  Future<void> close() {
    userName.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
