part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.newsEveryThingList = const [],
    this.everyThingStatus = RequestStatusEnum.loading,
    this.errorMessage,
  });

  final List<NewsArticleModel> newsEveryThingList;
  final RequestStatusEnum everyThingStatus;
  final String? errorMessage;

  SearchState copyWith({
    List<NewsArticleModel>? newsEveryThingList,
    RequestStatusEnum? everyThingStatus,
    String? errorMessage,
  }) {
    return SearchState(
      newsEveryThingList: newsEveryThingList ?? this.newsEveryThingList,
      everyThingStatus: everyThingStatus ?? this.everyThingStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    newsEveryThingList,
    everyThingStatus,
    errorMessage,
  ];
}
