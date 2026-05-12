import 'package:flutter/material.dart';
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
              return (value.errorMessage?.isNotEmpty ?? false)
                  ? Center(
                      child: Text(value.errorMessage ?? 'An error occurred'),
                    )
                  : value.topHeadLineLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      value.newsTopHeadLineList[index].title,
                                    ),
                                  ),
                                  const Divider(),
                                  ListTile(
                                    title: Text(
                                      value
                                          .newsEveryThingList[index]
                                          .description,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
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
