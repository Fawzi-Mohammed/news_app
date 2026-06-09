import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/categories_screen.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/widgets/category_tabs.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ViewAllComponent(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<HomeCubit>(),
                        child: CategoriesScreen(),
                      ),
                    ),
                  );
                },
                title: 'Categories',
                titleColor: Color(0xFF141414),
              ),
              CategoryTabs(
                selectedCategory: state.selectedCategory,
                onCategorySelected: context
                    .read<HomeCubit>()
                    .updateSelectedCategory,
              ),
            ],
          ),
        );
      },
    );
  }
}
