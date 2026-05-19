import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
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
                  ViewAllComponent(title: 'Trending News', onTap: () {}),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: Consumer<HomeController>(
                      builder: (context, HomeController controller, child) {
                        switch (controller.everyThingStatus) {
                          case RequestStatesEnum.loading:
                            return TrendingNewsShimmer();
                          case RequestStatesEnum.error:
                            return Center(
                              child: Text(controller.errorMessage!),
                            );
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

                                return ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    8,
                                  ),

                                  child: SizedBox(
                                    width: 240,
                                    child: Stack(
                                      children: [
                                        CustomCachedNetworkImage(
                                          url: model.urlToImage ?? '',
                                          width: 240,
                                          height: 140,
                                        ),

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
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    model.publishedAt
                                                        .formateDateTime(),

                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFFFFFCFC),
                                                      fontWeight:
                                                          FontWeight.w400,
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
      ),
    );
  }
}
