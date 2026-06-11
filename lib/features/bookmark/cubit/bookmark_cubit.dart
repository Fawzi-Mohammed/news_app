import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/bookmark/data/bookmark_repository.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(const BookmarkState()) {
    _bookmarksListenable = _repository.bookmarkBox.listenable();
    _bookmarksListenable.addListener(_onBookmarksChanged);
    loadBookmarks();
  }

  final BookmarkRepository _repository = BookmarkRepository();
  late final ValueListenable<Box<BookmarkModel>> _bookmarksListenable;

  void _onBookmarksChanged() {
    if (!isClosed) {
      loadBookmarks();
    }
  }

  void loadBookmarks() {
    try {
      emit(state.copyWith(bookmarksStatus: RequestStatusEnum.loading));

      final bookmarks = state.searchQuery.isEmpty
          ? _repository.getBookmarks()
          : _repository.searchBookmarks(state.searchQuery);

      emit(
        state.copyWith(
          bookmarks: bookmarks,
          bookmarksStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          bookmarksStatus: RequestStatusEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<bool> toggleBookmark(NewsArticleModel article) async {
    try {
      final wasAdded = await _repository.toggleBookmark(article);
      loadBookmarks();
      return wasAdded;
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      return false;
    }
  }

  Future<void> addBookmark(NewsArticleModel article) async {
    try {
      await _repository.addBookmark(article);
      loadBookmarks();
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> removeBookmark(String articleUrl) async {
    try {
      await _repository.removeBookmark(articleUrl);
      loadBookmarks();
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  bool isArticleBookmarked(String? articleUrl) {
    return _repository.isBookmarked(articleUrl);
  }

  int get bookmarkCount => _repository.getBookmarkCount();

  Future<void> clearAllBookmarks() async {
    try {
      await _repository.clearAllBookmarks();
      loadBookmarks();
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void searchBookmarks(String query) {
    emit(state.copyWith(searchQuery: query));
    loadBookmarks();
  }

  NewsArticleModel getArticleFromBookmark(BookmarkModel bookmark) {
    return _repository.bookmarkToArticle(bookmark);
  }

  Future<void> refresh() async {
    loadBookmarks();
  }

  List<NewsArticleModel> get bookmarksAsArticles {
    return state.bookmarks
        .map((bookmark) => _repository.bookmarkToArticle(bookmark))
        .toList();
  }

  @override
  Future<void> close() {
    _bookmarksListenable.removeListener(_onBookmarksChanged);
    return super.close();
  }
}
