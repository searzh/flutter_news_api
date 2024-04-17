import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../1_domain/entities/article_entity.dart';
import '../../../injection.dart';
import '../../core/utils/sizes.dart';
import '../../core/widgets/hs_circular_progress_indicator.dart';
import 'details_cubit/details_cubit.dart';
import 'favorites_cubit/favorites_cubit.dart';

class DetailsPageWrapperProvider extends StatelessWidget {
  const DetailsPageWrapperProvider({super.key, required this.extra});

  final ArticleEntity extra;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DetailsCubit>()
            ..loadDetails(
              article: extra,
            ),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesCubit>()
            ..loadFavorites(
              article: extra,
            ),
        ),
      ],
      child: DetailsPage(extra: extra),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.extra});

  final ArticleEntity extra;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.pushReplacement('/sources');
            }
          },
        ),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesInitialState) {
                return IconButton(
                  onPressed: () {
                    context
                        .read<FavoritesCubit>()
                        .insertFavorite(article: extra);
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                  ),
                );
              }

              if (state is FavoritesLoadingState) {
                return IconButton(
                  onPressed: () {},
                  icon: const HSCircularProgressIndicator(),
                );
              }

              if (state is FavoritesLoadedState) {
                return IconButton(
                  onPressed: () {
                    context
                        .read<FavoritesCubit>()
                        .updateFavorite(article: extra);
                  },
                  icon: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: state.isFavorite ? Colors.red : null,
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsInitialState) {
            return const HSCircularProgressIndicator();
          }

          if (state is DetailsLoadingState) {
            return const HSCircularProgressIndicator();
          }

          if (state is DetailsLoadedState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    state.article.urlToImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return const Center(child: HSCircularProgressIndicator());
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Text('Some errors occurred!'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HSSizes.medium1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: HSSizes.small1),
                        Text(
                          state.article.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: HSSizes.medium2,
                          ),
                        ),
                        const SizedBox(height: HSSizes.small1),
                        Text(
                          'By ${state.article.author}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: HSSizes.small2,
                          ),
                        ),
                        const SizedBox(height: HSSizes.small1),
                        Text(
                          state.article.content,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: HSSizes.small1),
                        Text(
                          state.article.url,
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: HSSizes.small2,
                          ),
                        ),
                        const SizedBox(height: HSSizes.small1),
                        Text(
                          'Published at: ${state.article.publishedAt}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: HSSizes.small2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
