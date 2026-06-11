import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({String? category = 'general'});

  Future<List<NewsArticleModel>> getEveryThing({String? query = 'news'});
}

class NewsRepository extends BaseNewsRepository {
  final BaseApiService apiService;

  NewsRepository({required this.apiService});

  List<NewsArticleModel> _parseArticles(Map<String, dynamic> result) {
    final List<dynamic>? articles = result['articles'] as List<dynamic>?;

    if (articles == null) {
      final dynamic message = result['message'];
      if (message is String && message.isNotEmpty) {
        throw Exception(message);
      }
      return <NewsArticleModel>[];
    }

    return articles
        .whereType<Map>()
        .map(
          (article) =>
              NewsArticleModel.fromJson(Map<String, dynamic>.from(article)),
        )
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> getTopHeadLine({
    String? category = 'general',
  }) async {
    final Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadLineEndPoint,
      ApiConfig.newsBaseUrl,
      params: {'country': 'us', 'category': category},
    );

    return _parseArticles(result);
  }

  @override
  Future<List<NewsArticleModel>> getEveryThing({String? query = 'news'}) async {
    final Map<String, dynamic> result = await apiService.get(
      ApiConfig.everyThingEndPoint,
      ApiConfig.newsBaseUrl,
      params: {'q': query},
    );

    return _parseArticles(result);
  }
}
