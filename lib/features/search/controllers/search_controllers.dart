import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchScreenControllers extends ChangeNotifier with SafeNotify {
  final BaseNewsRepository newsRepository;
  List<NewsArticleModel> newsEveryThingList = [];
  RequestStatesEnum everyThingStatus = RequestStatesEnum.loading;
  String? errorMessage;
  final TextEditingController searchController = TextEditingController();

  SearchScreenControllers({required this.newsRepository});
  Future<void> getEveryThing() async {
    try {
      newsEveryThingList = await newsRepository.getEveryThing(
        query: searchController.value.text,
      );
      everyThingStatus = RequestStatesEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load data: $e';
      everyThingStatus = RequestStatesEnum.error;
    }
    safeNotify();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
