import 'package:flutter/material.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:news_app/features/home/widgets/category_tabs.dart';
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
              CategoryTabs(
                selectedCategory: value.selectedCategory,
                onCategorySelected: value.updateSelectedCategory,
              ),
            ],
          ),
        );
      },
    );
  }
}
