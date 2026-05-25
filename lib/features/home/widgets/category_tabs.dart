import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/theme/light_color.dart';

const List<String> categories = [
  'general',
  'business',
  'entertainment',
  'health',
  'science',
  'sports',
  'technology',
];

String getCategoryLabel(String category) {
  if (category == 'general') return 'Top News';
  return category[0].toUpperCase() + category.substring(1);
}

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final String? selectedCategory;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          separatorBuilder: (context, index) => SizedBox(width: AppSizes.w12),
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = selectedCategory == category;
            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    Text(
                      getCategoryLabel(category),
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
    );
  }
}
