import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:news_app/features/home/repos/news_repository.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(
        newsRepository: NewsRepository(apiService: ApiService()),
      ),

      builder: (context, child) {
        return Scaffold(
          body: Consumer<HomeController>(
            builder: (context, HomeController value, child) {
              return CustomScrollView(
                slivers: [
                  TrendingNews(),
                  SliverToBoxAdapter(child: SizedBox(height: AppSizes.h10)),

                  CategoriesList(),
                  TopHeadline(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
