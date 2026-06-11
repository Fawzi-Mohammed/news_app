import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/validation/app_validators.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/repos/auth_repo.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepo(AuthApiService())),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == RequestStatusEnum.loaded) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MainScreen();
                  },
                ),
                (route) => false,
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final authCubit = context.read<AuthCubit>();

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.pw16,
                    vertical: AppSizes.ph16,
                  ),
                  child: Form(
                    key: authCubit.formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: AppSizes.h45,
                              ),
                            ),
                            SizedBox(height: AppSizes.h40),
                            Text(
                              'Welcome to Newts',
                              style: AppTextStyles.screenHeadline,
                            ),
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: authCubit.userName,
                              hintText: 'Ahmed Ibrahim',
                              title: 'User Name',
                              validator: AppValidators.userName,
                            ),
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: authCubit.emailController,
                              hintText: 'usama@gmail.com',
                              title: 'Email',
                              validator: AppValidators.email,
                            ),
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: authCubit.passwordController,
                              hintText: '*************',
                              title: 'Password',
                              obscureText: true,
                              validator: AppValidators.password,
                            ),
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: authCubit.confirmPasswordController,
                              hintText: '*************',
                              title: 'Confirm Password',
                              obscureText: true,
                              validator: (value) =>
                                  AppValidators.confirmPassword(
                                    value,
                                    password: authCubit.passwordController.text,
                                  ),
                            ),
                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.ph8,
                                ),
                                child: Text(
                                  state.errorMessage!,
                                  style: AppTextStyles.errorText,
                                ),
                              ),
                            SizedBox(height: AppSizes.ph24),
                            SizedBox(
                              width: double.infinity,
                              height: AppSizes.h48,
                              child: ElevatedButton(
                                child: state.status == RequestStatusEnum.loading
                                    ? const CircularProgressIndicator()
                                    : const Text('Sign Up'),
                                onPressed: () {
                                  if (authCubit.formKey.currentState
                                          ?.validate() ??
                                      false) {
                                    authCubit.register(
                                      name: authCubit.userName.text.trim(),
                                      email: authCubit.emailController.text
                                          .trim(),
                                      password: authCubit
                                          .passwordController
                                          .text
                                          .trim(),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: AppSizes.ph24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Have an account ?',
                                  style: AppTextStyles.bodyRegular,
                                ),
                                //  const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Sign In'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
