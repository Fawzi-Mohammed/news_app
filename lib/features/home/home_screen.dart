import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
          HomeCubit(newsRepository: NewsRepository(apiService: ApiService())),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            TrendingNews(),
            SliverToBoxAdapter(child: SizedBox(height: AppSizes.h10)),
            CategoriesList(),
            TopHeadline(),
          ],
        ),
      ),
    );
  }
}
