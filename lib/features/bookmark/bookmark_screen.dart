import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/app_snack_bar.dart';
import 'package:news_app/features/bookmark/cubit/bookmark_cubit.dart';
import 'package:news_app/features/bookmark/widgets/empty_state.dart';
import 'package:news_app/features/home/components/news_item.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bookmarks"),
          centerTitle: true,
          actions: [
            BlocBuilder<BookmarkCubit, BookmarkState>(
              builder: (context, state) {
                if (state.bookmarks.isEmpty) return const SizedBox();

                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'clear') {
                      _showClearConfirmation(context);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'clear',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline, color: LightColors.error),
                          SizedBox(width: 8),
                          Text('Clear All'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            final controller = context.read<BookmarkCubit>();
            switch (state.bookmarksStatus) {
              case RequestStatusEnum.initial:
              case RequestStatusEnum.loading:
                return const Center(child: CircularProgressIndicator());

              case RequestStatusEnum.error:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      SizedBox(height: AppSizes.ph16),
                      Text(
                        state.errorMessage ?? 'An error occurred',
                        style: TextStyle(fontSize: AppSizes.sp16),
                      ),
                      SizedBox(height: AppSizes.ph16),
                      ElevatedButton(
                        onPressed: () => controller.loadBookmarks(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );

              case RequestStatusEnum.loaded:
                if (state.bookmarks.isEmpty) {
                  return const EmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () => controller.refresh(),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: AppSizes.ph16),
                          itemCount: state.bookmarks.length,
                          itemBuilder: (context, index) {
                            final bookmark = state.bookmarks[index];
                            final article = controller.getArticleFromBookmark(
                              bookmark,
                            );

                            return Dismissible(
                              key: Key(bookmark.url),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: AppSizes.pw20),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await _showDeleteConfirmation(context);
                              },
                              onDismissed: (direction) {
                                controller.removeBookmark(bookmark.url);
                                AppSnackBar.show(
                                  context,
                                  message: 'Bookmark removed',
                                  duration: const Duration(seconds: 2),
                                  actionLabel: 'Undo',
                                  onAction: () {
                                    controller.addBookmark(article);
                                  },
                                );
                              },
                              child: NewsItem(model: article),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return _showConfirmationDialog(
      context: context,
      title: 'Remove Bookmark',
      message: 'Are you sure you want to remove this bookmark?',
      confirmLabel: 'Remove',
    );
  }

  Future<void> _showClearConfirmation(BuildContext context) async {
    final controller = context.read<BookmarkCubit>();
    final bool shouldClear =
        await _showConfirmationDialog(
          context: context,
          title: 'Clear All Bookmarks',
          message:
              'Are you sure you want to remove all ${controller.bookmarkCount} bookmarks? This action cannot be undone.',
          confirmLabel: 'Clear All',
        ) ??
        false;

    if (!shouldClear || !context.mounted) {
      return;
    }

    controller.clearAllBookmarks();
    AppSnackBar.show(
      context,
      message: 'All bookmarks cleared',
      duration: const Duration(seconds: 2),
    );
  }

  Future<bool?> _showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r16),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.pw16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(dialogContext).textTheme.titleLarge,
                ),
                SizedBox(height: AppSizes.ph12),
                Text(
                  message,
                  style: Theme.of(dialogContext).textTheme.bodyMedium,
                ),
                SizedBox(height: AppSizes.ph24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44),
                          side: BorderSide(color: LightColors.inputBorder),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    SizedBox(width: AppSizes.w12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightColors.error,
                          minimumSize: const Size(0, 44),
                        ),
                        child: Text(confirmLabel),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
