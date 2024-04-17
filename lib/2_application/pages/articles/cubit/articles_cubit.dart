import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../1_domain/entities/article_entity.dart';
import '../../../../1_domain/failures/failures.dart';
import '../../../../1_domain/usecases/articles_usecases.dart';
import '../../../core/utils/functions.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit({required this.articlesUseCases})
      : super(
          const ArticlesInitialState(),
        );

  final ArticlesUseCases articlesUseCases;

  void articlesRequest({required String source}) async {
    emit(const ArticlesLoadingState());

    final failureOrArticles = await articlesUseCases.getArticles(
      source: source,
    );

    failureOrArticles.fold(
      (failure) => emit(
        ArticlesErrorState(
          message: mapFailureToMessage(failure),
          failure: failure,
        ),
      ),
      (articles) {
        if (articles.articles.isEmpty) {
          emit(
            ArticlesErrorState(
              message: mapFailureToMessage(EmptyFailure()),
              failure: EmptyFailure(),
            ),
          );
        } else {
          emit(ArticlesLoadedState(articles: articles.articles));
        }
      },
    );
  }
}
