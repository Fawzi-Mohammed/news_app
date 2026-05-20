import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_states_enum.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
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
              // return TopHeadlineShimmer();
              return Center(child: CircularProgressIndicator());
            case RequestStatesEnum.error:
              return Center(child: Text(value.errorMessage!));
            case RequestStatesEnum.loaded:
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppSizes.pw16,
                      top: AppSizes.ph16,
                      bottom: AppSizes.ph16,
                    ),
                    child: SizedBox(
                      height: AppSizes.h30,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        padding: EdgeInsets.only(right: AppSizes.pw16),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: AppSizes.w12),
                        itemBuilder: (context, index) {
                          bool isSelected =
                              value.selectedCategory == categories[index];
                          return GestureDetector(
                            onTap: () {
                              value.updateSelectedCategory(categories[index]);
                            },
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Text(
                                    categories[index][0].toUpperCase() +
                                        categories[index].substring(1),
                                    style: TextStyle(
                                      fontSize: AppSizes.sp16,
                                      fontWeight: FontWeight.w400,
                                      color: isSelected
                                          ? LightColors.primaryColor
                                          : Color(0xFF363636),
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(height: AppSizes.ph4),
                                    Container(
                                      height: AppSizes.h2,
                                      color: LightColors.primaryColor,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

final List<String> categories = [
  'business',
  'entertainment',
  'general',
  'health',
  'science',
  'sports',
  'technology',
];
