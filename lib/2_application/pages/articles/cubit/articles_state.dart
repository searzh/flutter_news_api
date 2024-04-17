part of 'articles_cubit.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object?> get props => [];
}

final class ArticlesInitialState extends ArticlesState {
  const ArticlesInitialState();
}

final class ArticlesLoadingState extends ArticlesState {
  const ArticlesLoadingState();
}

final class ArticlesLoadedState extends ArticlesState {
  const ArticlesLoadedState({required this.articles});

  final List<ArticleEntity> articles;

  @override
  List<Object?> get props => [articles];
}

final class ArticlesErrorState extends ArticlesState {
  const ArticlesErrorState({required this.message, required this.failure});

  final String message;
  final Failure failure;

  @override
  List<Object?> get props => [message, failure];
}
