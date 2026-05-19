import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.url,
    this.height,
    this.width,
  });
  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      width: width ?? 140,
      height: height ?? 80,
      fit: BoxFit.cover,
      errorWidget: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
      placeholder: (context, url) => Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: height ?? 80,
            width: width ?? 140,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
