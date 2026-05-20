import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, HomeController value, child) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ViewAllComponent(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: context.read<HomeController>(),
                        child: CategoriesScreen(),
                      ),
                    ),
                  );
                },
                title: 'Categories',
                titleColor: Color(0xFF141414),
              ),
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
            ],
          ),
        );
      },
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
