import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  static const String _profileImagePathKey = 'profile_image_path';

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image == null) {
      return;
    }

    await PreferenceManger().setString(_profileImagePathKey, image.path);
    emit(state.copyWith(selectedImage: image));
  }

  void getUserData() {
    final user = UserRepository().getUser();
    final String? savedImagePath = PreferenceManger().getString(
      _profileImagePathKey,
    );

    emit(
      state.copyWith(
        selectedImage:
            savedImagePath != null &&
                savedImagePath.isNotEmpty &&
                File(savedImagePath).existsSync()
            ? XFile(savedImagePath)
            : null,
        userName: user?.name ?? '',
        userEmail: user?.email ?? '',
        countryName: user?.countryName,
        countryCode: user?.countryCode,
      ),
    );
  }

  Future<void> saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );

    emit(
      state.copyWith(
        countryName: selectedCountry.name,
        countryCode: selectedCountry.countryCode,
      ),
    );
  }
}
