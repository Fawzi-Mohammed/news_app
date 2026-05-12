import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController extends ChangeNotifier {
  bool topHeadLineLoading = true;
  bool everyThingLoading = true;
  String? errorMessage;
  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  HomeController() {
    getTopHeadLine();
    getEveryThing();
  }

  void getTopHeadLine() async {
    try {
      final result = await apiService.get(
        ApiConfig.topHeadLineEndPoint,
        params: {'country': 'us'},
      );
      newsTopHeadLineList = (result['articles'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      topHeadLineLoading = false;
      errorMessage = null;
    } on Exception catch (e) {
      errorMessage = 'Failed to load data: $e';
      topHeadLineLoading = false;
    }
    notifyListeners();
  }

  void getEveryThing() async {
    try {
      final Map<String, dynamic> result = await apiService.get(
        ApiConfig.everyThingEndPoint,
        params: {'q': 'sports', 'language': 'ar'},
      );

      newsEveryThingList = (result['articles'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      everyThingLoading = false;
      errorMessage = null;
    } on Exception catch (e) {
      errorMessage = 'Failed to load data: $e';
      everyThingLoading = false;
    }
    notifyListeners();
  }
}
