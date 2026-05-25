import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/core/repos/news_repository.dart';

class HomeController extends ChangeNotifier with SafeNotify {
  RequestStatesEnum topHeadLineStatus = RequestStatesEnum.loading;
  RequestStatesEnum everyThingStatus = RequestStatesEnum.loading;
  String? errorMessage;
  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEveryThingList = [];
  ApiService apiService = ApiService();
  String? selectedCategory = 'general';
  final BaseNewsRepository newsRepository;
  HomeController({required this.newsRepository}) {
    getTopHeadLine(category: selectedCategory);
    getEveryThing();
  }

  Future<void> getTopHeadLine({String? category}) async {
    try {
      topHeadLineStatus = RequestStatesEnum.loading;
      safeNotify();
      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        category: category,
      );

      topHeadLineStatus = RequestStatesEnum.loaded;
      errorMessage = null;
    } on Exception catch (e) {
      errorMessage = 'Failed to load data: $e';
      topHeadLineStatus = RequestStatesEnum.error;
    }
    safeNotify();
  }

  Future<void> getEveryThing() async {
    try {
      newsEveryThingList = await newsRepository.getEveryThing();
      everyThingStatus = RequestStatesEnum.loaded;
      errorMessage = null;
    } on Exception catch (e) {
      errorMessage = 'Failed to load data: $e';
      everyThingStatus = RequestStatesEnum.error;
    }
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
  }
}
