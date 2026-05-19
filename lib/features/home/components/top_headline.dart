
import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/components/top_headline_shimmer.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, HomeController value, child) {
        switch (value.topHeadLineStatus) {
          case RequestStatesEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatesEnum.error:
            return SliverToBoxAdapter(
              child: Center(child: Text(value.errorMessage!)),
            );
          case RequestStatesEnum.loaded:
            return SliverList.builder(
              itemCount: value.newsTopHeadLineList.length,
              itemBuilder: (context, index) {
                final model = value.newsTopHeadLineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
