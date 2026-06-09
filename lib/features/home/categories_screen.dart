import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';
import 'package:news_app/features/home/widgets/categories_news_shimmer.dart';
import 'package:news_app/features/home/widgets/category_tabs.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.newsTopHeadLineStatus) {
            case RequestStatusEnum.loading:
              return Column(
                children: [
                  CategoryTabs(
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: context
                        .read<HomeCubit>()
                        .updateSelectedCategory,
                  ),
                  Expanded(child: CategoriesNewsShimmer()),
                ],
              );
            case RequestStatusEnum.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case RequestStatusEnum.loaded:
              return Column(
                children: [
                  CategoryTabs(
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: context
                        .read<HomeCubit>()
                        .updateSelectedCategory,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.newsTopHeadLineList.length,
                      itemBuilder: (context, index) {
                        final model = state.newsTopHeadLineList[index];
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
