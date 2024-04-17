import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../1_domain/entities/article_entity.dart';
import '../../../injection.dart';
import '../../core/utils/sizes.dart';
import '../../core/widgets/hs_circular_progress_indicator.dart';
import 'cubit/details_cubit.dart';

class DetailsPageWrapperProvider extends StatelessWidget {
  const DetailsPageWrapperProvider({super.key, required this.extra});

  final ArticleEntity extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DetailsCubit>()..loadDetails(article: extra),
      child: const DetailsPage(),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Articles',
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
