import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    usernameController.text = PreferenceManger().getString('username') ?? '';
    emailController.text = PreferenceManger().getString('user_email') ?? '';
  }

  Future<void> _saveUserData() async {
    if (keyForm.currentState?.validate() ?? false) {
      await PreferenceManger().setString(
        'username',
        usernameController.text.trim(),
      );
      await PreferenceManger().setString(
        'user_email',
        emailController.text.trim(),
      );
      if (!mounted) {
        return;
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.85,
          ),
          decoration: BoxDecoration(
            color: LightColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.r16),
              topRight: Radius.circular(AppSizes.r16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Container(
                        width: AppSizes.w42,
                        height: AppSizes.h2,
                        decoration: BoxDecoration(
                          color: const Color(0xFF363636),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.ph16),
                    Text(
                      'Profile Info',
                      style: TextStyle(
                        fontSize: AppSizes.sp16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: AppSizes.ph16),
                    CustomTextFormField(
                      controller: usernameController,
                      hintText: 'Ahmed Ibrahim',
                      title: 'User Name',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please Enter User Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppSizes.ph16),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'usama@gmail.com',
                      title: 'Email',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please Enter Email';
                        }
                        final RegExp emailRegExp = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppSizes.h40),
                    ElevatedButton(
                      onPressed: _saveUserData,
                      child: const Text('Save'),
                    ),
                    SizedBox(height: AppSizes.ph16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
