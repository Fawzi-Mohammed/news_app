import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remote_data/news/news_api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/details/details_screen.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';
import 'package:news_app/features/search/widgets/custom_search_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(
        newsRepository: NewsRepository(apiService: NewsApiService()),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Search')),
        body: Padding(
          padding: EdgeInsets.all(AppSizes.ph16),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              final controller = context.read<SearchCubit>();
              return Column(
                children: [
                  CustomSearchTextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getEveryThing();
                    },
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: state.newsEveryThingList.length,
                      itemBuilder: (context, index) {
                        final model = state.newsEveryThingList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.pw8,
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(model: model),
                                ),
                              );
                            },
                            title: Text(model.title, maxLines: 1),
                            leading: CustomSvgPicture.withColorFilter(
                              path: 'assets/images/search_icon.svg',
                              height: AppSizes.h16,
                              width: AppSizes.w16,
                            ),
                            titleTextStyle: TextStyle(
                              color: Color(0xFF6D6D6D),
                              fontWeight: FontWeight.w400,
                              fontSize: AppSizes.sp16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
