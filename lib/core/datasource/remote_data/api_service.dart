import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';

abstract class BaseApiService {
  Future<dynamic> get(
    String endPoint,
    String baseUrl, {
    Map<String, String?>? params,
  });
  Future<dynamic> post(
    String endPoint,
    String baseUrl, {
    Map<String, String?>? body,
  });
  Future<dynamic> getWithToken(String endPoint, String baseUrl, String? token);
}

class ApiService extends BaseApiService {
  @override
  Future<dynamic> get(
    String endPoint,
    String baseUrl, {
    Map<String, String?>? params,
  }) async {
    final url = Uri.https(baseUrl, 'v2/$endPoint', {
      'apiKey': ApiConfig.apiKey,
      ...?params,
    });
    try {
      final http.Response response = await http.get(url);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody['message']);
      }
    } on Exception catch (_) {
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<dynamic> post(
    String endPoint,
    String baseUrl, {
    Map<String, String?>? body,
  }) async {
    final url = Uri.https(baseUrl, endPoint);
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
    final accessToken = UserRepository().getUser()?.accessToken;
    if (accessToken != null) {
      headers['Authorization'] =
          'Bearer $accessToken'; // Add the access token to the headers
    }
    try {
      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody['message']);
      }
    } on Exception catch (_) {
      throw Exception('Failed to post data');
    }
  }

  @override
  Future<dynamic> getWithToken(
    String endPoint,
    String baseUrl,
    String? token,
  ) async {
    final url = Uri.https(baseUrl, endPoint);
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    try {
      final http.Response response = await http.get(url, headers: headers);
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (e) {
      throw Exception('Failed to load data with token');
    }
  }
}
