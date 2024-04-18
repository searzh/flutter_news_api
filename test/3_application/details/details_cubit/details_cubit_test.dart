import 'package:flutter_challenge_hs/1_domain/entities/article_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/article_source_entity.dart';
import 'package:flutter_challenge_hs/2_application/pages/details/details_cubit/details_cubit.dart';

import 'package:test/scaffolding.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group(
    'DetailsCubit',
    () {
      group(
        'Should emit',
        () {
          blocTest(
            'Nothing when no method is called',
            build: () => DetailsCubit(),
            expect: () => <DetailsState>[],
          );

          blocTest(
            '[DetailsLoadingState, DetailsLoadedState] when loadDetails() is called',
            build: () => DetailsCubit(),
            act: (cubit) => cubit.loadDetails(
              article: const ArticleEntity(
                author: 'John Doe',
                title: 'Breaking News',
                description: 'This is a news article',
                url: 'https://example.com',
                urlToImage: 'https://example.com/image.jpg',
                publishedAt: '2023-04-18T12:00:00Z',
                content: 'This is the content of the article',
                source: ArticleSourceEntity(
                  id: 'abc-news',
                  name: 'ABC News',
                ),
              ),
            ),
            expect: () => <DetailsState>[
              const DetailsLoadingState(),
              const DetailsLoadedState(
                article: ArticleEntity(
                  author: 'John Doe',
                  title: 'Breaking News',
                  description: 'This is a news article',
                  url: 'https://example.com',
                  urlToImage: 'https://example.com/image.jpg',
                  publishedAt: '2023-04-18T12:00:00Z',
                  content: 'This is the content of the article',
                  source: ArticleSourceEntity(
                    id: 'abc-news',
                    name: 'ABC News',
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
