import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.newsRepository}) : super(const SearchState());

  final BaseNewsRepository newsRepository;
  final TextEditingController searchController = TextEditingController();

  Future<void> getEveryThing() async {
    try {
      final articles = await newsRepository.getEveryThing(
        query: searchController.text,
      );

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

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
