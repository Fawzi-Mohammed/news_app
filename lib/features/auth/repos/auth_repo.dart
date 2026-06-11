
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/models/user_model.dart';

class AuthRepo {
  final ApiService _apiService;
  AuthRepo(this._apiService);

  Future<UserModel?> login({
    required String userName,
    required String password,
  }) async {
    final response = await _apiService.post(
      ApiConfig.loginEndPoint,
      ApiConfig.authBaseUrl,

      /// the useName is : emilys
      ///  the password is : emilyspass
      body: {'username': userName, 'password': password},
    );
    UserModel userModel = UserModel.fromAuthResponse(response, userName);
    await _saveUser(userModel);
    // log(
    //   'User logged in: ${userModel.name}, Access Token: ${userModel.accessToken}',
    // );
    return userModel;
  }

  Future<void> _saveUser(UserModel userModel) async {
    await UserRepository().saveUser(userModel);
  }
}
