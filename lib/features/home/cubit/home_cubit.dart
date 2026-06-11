import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.newsRepository}) : super(const HomeState()) {
    getTopHeadLine(category: state.selectedCategory);
    getEveryThing();
  }

  final BaseNewsRepository newsRepository;

  Future<void> getTopHeadLine({String? category}) async {
    try {
      emit(state.copyWith(newsTopHeadLineStatus: RequestStatusEnum.loading));

      final articles = await newsRepository.getTopHeadLine(category: category);

      emit(
        state.copyWith(
          newsTopHeadLineList: articles,
          newsTopHeadLineStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          newsTopHeadLineStatus: RequestStatusEnum.error,
          errorMessage: 'Failed to load data: $e',
        ),
      );
    }
  }

  Future<void> getEveryThing() async {
    try {
      final articles = await newsRepository.getEveryThing();

      emit(
        state.copyWith(
          newsEveryThingList: articles,
          everyThingStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          everyThingStatus: RequestStatusEnum.error,
          errorMessage: 'Failed to load data: $e',
        ),
      );
    }
  }

  void updateSelectedCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
    getTopHeadLine(category: category);
  }
}
