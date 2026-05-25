import 'package:hive_ce_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? password;
  @HiveField(3)
  final String? countryName;
  @HiveField(4)
  final String? countryCode;
  @HiveField(5)
  final String? profileImagePath;

  UserModel({
    required this.name,
    required this.email,
    this.password,
    this.countryName,
    this.countryCode,
    this.profileImagePath,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
    String? profileImagePath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
