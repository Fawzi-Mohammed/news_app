import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (context, index) {
        return SizedBox(width: 12);
      },
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: 140, width: 240, color: Colors.white),
        );
      },
    );
  }
}
