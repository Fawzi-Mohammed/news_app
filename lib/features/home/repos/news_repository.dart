import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({String? category = 'general'});
  Future<List<NewsArticleModel>> getEveryThing();
}

class NewsRepository extends BaseNewsRepository {
  final BaseApiService apiService;
  NewsRepository({required this.apiService});
  @override
  Future<List<NewsArticleModel>> getTopHeadLine({
    String? category = 'general',
  }) async {
    final result = await apiService.get(
      ApiConfig.topHeadLineEndPoint,
      params: {'country': 'us', 'category': ?category},
    );
    return (result['articles'] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> getEveryThing() async {
    final Map<String, dynamic> result = await apiService.get(
      ApiConfig.everyThingEndPoint,
      params: {'q': 'sports', 'language': 'ar'},
    );

    return (result['articles'] as List)
        .map((e) => NewsArticleModel.fromJson(e))
        .toList();
  }
}
