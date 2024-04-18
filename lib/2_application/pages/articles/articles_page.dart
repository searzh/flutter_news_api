import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../core/utils/sizes.dart';
import '../../core/widgets/hs_circular_progress_indicator.dart';
import '../../core/widgets/hs_error_message.dart';
import 'articles_cubit/articles_cubit.dart';
import 'widgets/article_list_tile.dart';

class ArticlesPageWrapperProvider extends StatelessWidget {
  const ArticlesPageWrapperProvider({super.key, required this.extra});

  final String extra;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ArticlesCubit>()..articlesRequest(source: extra),
      child: const ArticlesPage(),
    );
  }
}

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HSSizes.medium1),
        child: BlocBuilder<ArticlesCubit, ArticlesState>(
          builder: (context, state) {
            if (state is ArticlesInitialState) {
              return const HSCircularProgressIndicator();
            }

            if (state is ArticlesLoadingState) {
              return const HSCircularProgressIndicator();
            }

            if (state is ArticlesLoadedState) {
              return ListView.builder(
                itemCount: max(1, state.articles.length - 1),
                itemBuilder: (context, index) {
                  return ArticleListTile(
                    article: state.articles[index],
                  );
                },
              );
            }

            if (state is ArticlesErrorState) {
              return Center(
                child: HSErrorMessage(
                  message: state.message,
                  failure: state.failure,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
