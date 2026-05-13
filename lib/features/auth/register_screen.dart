import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/features/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 45),
                ),
                const SizedBox(height: 40),
                Text(
                  'Welcome to Newts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'usama@gmail.com',
                  title: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    RegExp emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: '*************',
                  title: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Password";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: '*************',
                  title: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Confirm Your Password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : const Text('Sign Up'),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Perform registration logic here
                        register();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account ?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
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
  }

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PreferenceManger().getString('user_email');
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = 'User Already Registered';
        isLoading = false;
      });
    } else {
      await PreferenceManger().setString(
        'user_email',
        emailController.text.trim(),
      );
      await PreferenceManger().setString(
        'user_password',
        passwordController.text.trim(),
      );
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
            return MainScreen();
          },
        ),
        (route) => false,
      );
    }
  }
}
