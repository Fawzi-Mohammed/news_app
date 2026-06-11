import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preference_manger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/main.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? token = UserRepository().getUser()?.accessToken;

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final BuildContext context = navigatorKey.currentContext!;

      UserRepository().delete();
      PreferenceManger().clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const LoginScreen();
          },
        ),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session Expire, Please Login Again')),
      );
    }

    handler.next(err);
  }
}
