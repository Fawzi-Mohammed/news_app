import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/widgets/app_snack_bar.dart';
import 'package:news_app/features/bookmark/data/bookmark_repository.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class BookmarkButton extends StatefulWidget {
  final NewsArticleModel article;
  final double size;

  const BookmarkButton({super.key, required this.article, this.size = 24.0});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  final BookmarkRepository _repository = BookmarkRepository();
  bool _isAnimating = false;

  Future<void> _toggleBookmark() async {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
    });

    try {
      final wasAdded = await _repository.toggleBookmark(widget.article);

      setState(() {
        _isAnimating = false;
      });

      // Show feedback to user
      if (mounted) {
        AppSnackBar.show(
          context,
          message: wasAdded ? 'Article bookmarked' : 'Bookmark removed',
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      setState(() {
        _isAnimating = false;
      });

      if (mounted) {
        AppSnackBar.show(
          context,
          message: 'Error: ${e.toString()}',
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<BookmarkModel>>(
      valueListenable: _repository.bookmarkBox.listenable(),
      builder: (context, box, child) {
        final articleUrl = widget.article.url;
        final isBookmarked =
            articleUrl != null &&
            articleUrl.isNotEmpty &&
            box.containsKey(articleUrl);
        return GestureDetector(
          onTap: _toggleBookmark,
          child: AnimatedScale(
            scale: _isAnimating ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                key: ValueKey<bool>(isBookmarked),
                size: widget.size,
                color: isBookmarked
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
