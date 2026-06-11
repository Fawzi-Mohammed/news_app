part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.everyThingStatus = RequestStatusEnum.loading,
    this.newsTopHeadLineStatus = RequestStatusEnum.loading,
    this.errorMessage,
    this.selectedCategory = 'general',
    this.newsTopHeadLineList = const [],
    this.newsEveryThingList = const [],
  });

  final RequestStatusEnum everyThingStatus;
  final RequestStatusEnum newsTopHeadLineStatus;
  final String? errorMessage;
  final String? selectedCategory;
  final List<NewsArticleModel> newsTopHeadLineList;
  final List<NewsArticleModel> newsEveryThingList;

  HomeState copyWith({
    RequestStatusEnum? everyThingStatus,
    RequestStatusEnum? newsTopHeadLineStatus,
    String? errorMessage,
    String? selectedCategory,
    List<NewsArticleModel>? newsTopHeadLineList,
    List<NewsArticleModel>? newsEveryThingList,
  }) {
    return HomeState(
      everyThingStatus: everyThingStatus ?? this.everyThingStatus,
      newsTopHeadLineStatus:
          newsTopHeadLineStatus ?? this.newsTopHeadLineStatus,
      errorMessage: errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      newsTopHeadLineList: newsTopHeadLineList ?? this.newsTopHeadLineList,
      newsEveryThingList: newsEveryThingList ?? this.newsEveryThingList,
    );
  }

  @override
  List<Object?> get props => [
    everyThingStatus,
    newsTopHeadLineStatus,
    errorMessage,
    selectedCategory,
    newsTopHeadLineList,
    newsEveryThingList,
  ];
}
