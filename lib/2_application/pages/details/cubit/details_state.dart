part of 'details_cubit.dart';

sealed class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

final class DetailsInitialState extends DetailsState {
  const DetailsInitialState();
}

final class DetailsLoadingState extends DetailsState {
  const DetailsLoadingState();
}

final class DetailsLoadedState extends DetailsState {
  const DetailsLoadedState({required this.article});

  final ArticleEntity article;

  @override
  List<Object?> get props => [article];
}
