import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/details/details_screen.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(model: model)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pw16,
          vertical: AppSizes.ph8,
        ),
        child: SizedBox(
          height: AppSizes.h80,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(AppSizes.r8),
                child: CustomCachedNetworkImage(url: model.urlToImage ?? ''),
              ),
              SizedBox(width: AppSizes.pw8),
              Expanded(
                child: Column(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: AppSizes.sp16,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: AppSizes.r10,
                          backgroundColor: Colors.black26,
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: AppSizes.sp12,
                          ),
                        ),
                        SizedBox(width: AppSizes.w6),
                        Text(
                          (model.author ?? '').substring(
                            0,
                            min(model.author?.length ?? 0, 10),
                          ),
                          style: TextStyle(
                            fontSize: AppSizes.sp12,
                            color: Color(0xFF141414),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: AppSizes.pw8),
                        Expanded(
                          child: Text(
                            model.publishedAt.formateDateTime(),
                            style: TextStyle(
                              color: Color(0xFF363636),
                              fontSize: AppSizes.sp12,
                            ),
                          ),
                        ),

                        CustomSvgPicture.withColorFilter(
                          path: 'assets/images/bookmark_icon.svg',
                          width: AppSizes.w12,
                          height: AppSizes.h15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
