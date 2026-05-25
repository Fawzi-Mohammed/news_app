import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  static const String _profileImagePathKey = 'profile_image_path';

  XFile? selectedImage;

  String? userName;
  String? userEmail;
  String? countryCode;
  String? countryName;

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }

    selectedImage = image;
    await PreferenceManger().setString(_profileImagePathKey, image.path);

    safeNotify();
  }

  void getUserData() {
    final user = UserRepository().getUser();
    userName = user?.name ?? '';
    userEmail = user?.email ?? '';
    countryName = user?.countryName;
    countryCode = user?.countryCode;
    final String? savedImagePath = PreferenceManger().getString(
      _profileImagePathKey,
    );
    if (savedImagePath != null &&
        savedImagePath.isNotEmpty &&
        File(savedImagePath).existsSync()) {
      selectedImage = XFile(savedImagePath);
    } else {
      selectedImage = null;
    }
    safeNotify();
  }

  Future<void> saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    safeNotify();
  }
}
