import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/validation/app_validators.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/cubit/auth_cubit.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/auth/repos/auth_repo.dart';
import 'package:news_app/features/main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: AuthRepo(ApiService())),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == RequestStatusEnum.loaded) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
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
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.pw16,
                    vertical: AppSizes.ph16,
                  ),
                  child: Form(
                    key: context.read<AuthCubit>().formKey,
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
                              controller: context.read<AuthCubit>().userName,
                              hintText: 'usama',
                              title: 'Username',
                              validator: AppValidators.userName,
                            ),
                            SizedBox(height: AppSizes.ph24),
                            CustomTextFormField(
                              controller: context
                                  .read<AuthCubit>()
                                  .passwordController,
                              hintText: '*************',
                              title: 'Password',
                              obscureText: true,
                              validator: AppValidators.password,
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
                                    : const Text('Sign In'),
                                onPressed: () {
                                  if (context
                                          .read<AuthCubit>()
                                          .formKey
                                          .currentState
                                          ?.validate() ??
                                      false) {
                                    context.read<AuthCubit>().login(
                                      userName: context
                                          .read<AuthCubit>()
                                          .userName
                                          .text
                                          .trim(),
                                      password: context
                                          .read<AuthCubit>()
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
                                  'Don’t have an account ?',
                                  style: AppTextStyles.bodyRegular,
                                ),
                                //  const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text('Sign Up'),
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
