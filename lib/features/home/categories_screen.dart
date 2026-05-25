import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:news_app/features/home/widgets/categories_news_shimmer.dart';
import 'package:news_app/features/home/widgets/category_tabs.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Consumer<HomeController>(
        builder: (context, HomeController value, child) {
          switch (value.topHeadLineStatus) {
            case RequestStatesEnum.loading:
              return Column(
                children: [
                  CategoryTabs(
                    selectedCategory: value.selectedCategory,
                    onCategorySelected: value.updateSelectedCategory,
                  ),
                  Expanded(child: CategoriesNewsShimmer()),
                ],
              );
            case RequestStatesEnum.error:
              return Center(child: Text(value.errorMessage!));
            case RequestStatesEnum.loaded:
              return Column(
                children: [
                  CategoryTabs(
                    selectedCategory: value.selectedCategory,
                    onCategorySelected: value.updateSelectedCategory,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.newsTopHeadLineList.length,
                      itemBuilder: (context, index) {
                        final model = value.newsTopHeadLineList[index];
                        return NewsItem(model: model);
                      },
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
