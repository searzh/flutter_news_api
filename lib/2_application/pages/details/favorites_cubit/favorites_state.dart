part of 'favorites_cubit.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

final class FavoritesInitialState extends FavoritesState {
  const FavoritesInitialState();
}

final class FavoritesLoadingState extends FavoritesState {
  const FavoritesLoadingState();
}

final class FavoritesLoadedState extends FavoritesState {
  const FavoritesLoadedState({required this.isFavorite});

  final bool isFavorite;

  @override
  List<Object?> get props => [isFavorite];
}
