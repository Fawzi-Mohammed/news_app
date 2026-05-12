import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/api_config.dart';

class ApiService {
  Future<dynamic> get(String endPoint, {Map<String, String>? params}) async {
    final url = Uri.https(ApiConfig.baseUrl, 'v2/$endPoint', {
      'apiKey': ApiConfig.apiKey,
      ...?params,
    });
    try {
      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    } on Exception catch (_) {
      throw Exception('Failed to load data');
    }
  }
}
