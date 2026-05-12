//  {
//             "source": {
//                 "id": "al-jazeera-english",
//                 "name": "Al Jazeera English"
//             },
//             "author": "Al Jazeera Staff",
//             "title": "Russia holds downsized Victory Day parade - Al Jazeera",
//             "description": "Putin invoked the Soviet victory in World War II to rally his army in Ukraine, saying ‘our heroes move forward’.",
//             "url": "https://www.aljazeera.com/news/2026/5/9/russia-holds-downsized-victory-day",
//             "urlToImage": "https://www.aljazeera.com/wp-content/uploads/2026/05/reuters_69fee5c1-1778312641.jpg?resize=1920%2C1440",
//             "publishedAt": "2026-05-09T10:56:53Z",
//             "content": "Russia has held its annual Victory Day military parade in Moscow to mark the defeat of Nazi Germany during the second world war.\r\nThe parade, scaled back this year due to security concerns, started a… [+3256 chars]"
//         },

class NewsArticleModel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      author: json['author'] ?? '',
      title: json['title']??'',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
