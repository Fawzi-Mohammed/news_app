import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                Text(
                  'NEWST',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    color: LightColors.primaryColor,
                  ),
                ),

                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: .center,
                    children: [
                      Text(
                        'Trending News',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder: (context, HomeController controller, child) {
                      switch (controller.everyThingStatus) {
                        case RequestStatesEnum.loading:
                          return Center(child: CircularProgressIndicator());
                        case RequestStatesEnum.error:
                          return Center(child: Text(controller.errorMessage!));
                        case RequestStatesEnum.loaded:
                          return ListView.separated(
                            padding: EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.newsEveryThingList.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 12);
                            },
                            itemBuilder: (context, index) {
                              final model =
                                  controller.newsEveryThingList[index];
                              final imageUrl = _normalizedImageUrl(
                                model.urlToImage,
                              );
                              return ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(8),

                                child: SizedBox(
                                  width: 240,
                                  child: Stack(
                                    children: [
                                      if (imageUrl != null)
                                        Image.network(
                                          imageUrl,
                                          width: 240,
                                          height: 140,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  _buildCardImageFallback(),
                                        )
                                      else
                                        _buildCardImageFallback(),
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.black.withValues(
                                                  alpha: 0.5,
                                                ),
                                                Colors.black.withValues(
                                                  alpha: 0.7,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 12,
                                        right: 12,

                                        bottom: 12,
                                        child: Column(
                                          crossAxisAlignment: .start,
                                          children: [
                                            Text(
                                              model.title,
                                              style: TextStyle(
                                                color: Color(0xFFFFFCFC),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 6),

                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      const CircleAvatar(
                                                        radius: 10,
                                                        backgroundColor:
                                                            Colors.white24,
                                                        child: Icon(
                                                          Icons.person,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                      ),
                                                      SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          model.author ?? '',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                              0xFFFFFCFC,
                                                            ),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  formateDateTime(
                                                    model.publishedAt,
                                                  ),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFFFFFCFC),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formateDateTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    }

    return '${diff.inDays} days ago';
  }

  String? _normalizedImageUrl(String? rawUrl) {
    if (rawUrl == null) return null;

    final trimmedUrl = rawUrl.trim();
    if (trimmedUrl.isEmpty || trimmedUrl.toLowerCase() == 'null') return null;

    final uri = Uri.tryParse(trimmedUrl);
    if (uri == null || !uri.hasScheme || uri.host.isEmpty) return null;
    if (uri.scheme != 'http' && uri.scheme != 'https') return null;

    return trimmedUrl;
  }

  Widget _buildCardImageFallback() {
    return Container(
      width: 240,
      height: 140,
      color: Colors.black26,
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        color: Colors.white.withValues(alpha: 0.8),
        size: 22,
      ),
    );
  }
}
