import 'package:flutter/material.dart';
import 'package:news_app/features/home/components/trending_news.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controllers/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(),

      builder: (context, child) {
        return Scaffold(
          body: Consumer<HomeController>(
            builder: (context, HomeController value, child) {
              return Column(
                children: [
                  TrendingNews(),
                  SizedBox(height: 10),
                  ViewAllComponent(
                    onTap: () {},

                    title: 'Categories',
                    titleColor: Color(0xFF141414),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
