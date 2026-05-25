import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/theme/app_text_styles.dart';
import 'package:news_app/core/validation/app_validators.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/auth/register_screen.dart';
import 'package:news_app/features/main/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pw16,
            vertical: AppSizes.ph16,
          ),
          child: Form(
            key: _formKey,
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
                      controller: emailController,
                      hintText: 'usama@gmail.com',
                      title: 'Email',
                      validator: AppValidators.email,
                    ),
                    SizedBox(height: AppSizes.ph24),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: '*************',
                      title: 'Password',
                      obscureText: true,
                      validator: AppValidators.password,
                    ),
                    if (errorMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSizes.ph8),
                        child: Text(
                          errorMessage!,
                          style: AppTextStyles.errorText,
                        ),
                      ),
                    SizedBox(height: AppSizes.ph24),

                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.h48,
                      child: ElevatedButton(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Sign In'),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            login();
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
                                builder: (context) => const RegisterScreen(),
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
        ),
      ),
    );
  }

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    final String? error = UserRepository().login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }
    await PreferenceManger().setBool('is_logged_in', true);
    setState(() {
      isLoading = false;
      errorMessage = null;
    });
    if (!mounted) return;
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
}
