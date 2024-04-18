import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../1_domain/entities/article_entity.dart';
import '../../../core/storage/database_helper.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesInitialState());

  void loadFavorites({required ArticleEntity article}) async {
    emit(const FavoritesLoadingState());

    final database = await DatabaseHelper().database;

    final List<Map<String, Object?>> favorites = await database.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [article.publishedAt],
    );

    final String id = article.publishedAt;

    if (favorites.isEmpty) {
      emit(const FavoritesInitialState());
      return;
    }

    for (final favorite in favorites) {
      final String storedId = favorite['id'] as String;

      final int storedIsFavorite = favorite['isFavorite'] as int;

      if (storedId == id && storedIsFavorite == 1) {
        emit(const FavoritesLoadedState(isFavorite: true));
        return;
      }

      emit(const FavoritesLoadedState(isFavorite: false));
    }
  }

  void updateFavorite({required ArticleEntity article}) async {
    emit(const FavoritesLoadingState());

    final database = await DatabaseHelper().database;

    final List<Map<String, Object?>> favorites = await database.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [article.publishedAt],
    );

    final String id = article.publishedAt;

    int storedIsFavorite = 0;

    for (final favorite in favorites) {
      final String storedId = favorite['id'] as String;

      storedIsFavorite = favorite['isFavorite'] as int;

      if (storedId == id && storedIsFavorite == 1) {
        final toggleFavorite = storedIsFavorite == 0 ? 1 : 0;

        await database.update(
          'favorites',
          <String, dynamic>{
            'id': article.publishedAt,
            'isFavorite': toggleFavorite,
          },
          where: 'id = ?',
          whereArgs: [article.publishedAt],
        );

        if (toggleFavorite == 0) {
          emit(const FavoritesLoadedState(isFavorite: false));
          return;
        }

        emit(const FavoritesLoadedState(isFavorite: false));
        return;
      }
    }
  }

  Future<void> insertFavorite({required ArticleEntity article}) async {
    final database = await DatabaseHelper().database;

    await database.insert(
      'favorites',
      <String, dynamic>{
        'id': article.publishedAt,
        'isFavorite': 1,
      },
    );

    emit(const FavoritesLoadedState(isFavorite: true));
  }
}
