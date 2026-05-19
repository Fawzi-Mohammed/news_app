import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticleModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: CustomCachedNetworkImage(url: model.urlToImage ?? ''),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black26,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 12,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        (model.author ?? '').substring(
                          0,
                          min(model.author?.length ?? 0, 10),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF141414),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          model.publishedAt.formateDateTime(),
                          style: TextStyle(
                            color: Color(0xFF363636),
                            fontSize: 12,
                          ),
                        ),
                      ),

                      CustomSvgPicture.withColorFilter(
                        path: 'assets/images/bookmark_icon.svg',
                        width: 12,
                        height: 15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
