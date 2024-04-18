import 'package:flutter_challenge_hs/1_domain/entities/article_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/article_source_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/articles_entity.dart';
import 'package:flutter_challenge_hs/1_domain/failures/failures.dart';
import 'package:flutter_challenge_hs/1_domain/usecases/articles_usecases.dart';
import 'package:flutter_challenge_hs/2_application/core/utils/strings.dart';
import 'package:flutter_challenge_hs/2_application/pages/articles/articles_cubit/articles_cubit.dart';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';
import 'package:bloc_test/bloc_test.dart';

class MockArticlesUseCases extends Mock implements ArticlesUseCases {}

void main() {
  group(
    'ArticlesCubit',
    () {
      group(
        'Should emit',
        () {
          MockArticlesUseCases mockArticlesUseCases = MockArticlesUseCases();

          blocTest(
            'Nothing when no method is called',
            build: () => ArticlesCubit(articlesUseCases: mockArticlesUseCases),
            expect: () => <ArticlesState>[],
          );

          blocTest(
            '[ArticlesLoadingState, ArticlesLoadedState] when articlesRequest',
            setUp: () {
              when(
                () => mockArticlesUseCases.getArticles(source: 'abc-news'),
              ).thenAnswer(
                (invocation) => Future.value(
                  const Right<Failure, ArticlesEntity>(ArticlesEntity(
                    status: 'ok',
                    totalResults: 10,
                    articles: [
                      ArticleEntity(
                        author: 'Steven Shepard',
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
                    ],
                  )),
                ),
              );
            },
            build: () => ArticlesCubit(articlesUseCases: mockArticlesUseCases),
            act: (cubit) => cubit.articlesRequest(source: 'abc-news'),
            expect: () => <ArticlesState>[
              const ArticlesLoadingState(),
              const ArticlesLoadedState(
                articles: [
                  ArticleEntity(
                    author: 'Steven Shepard',
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
                ],
              ),
            ],
          );

          group(
            '[ArticlesLoadingState, ArticlesErrorState] when articlesRequest is called',
            () {
              blocTest(
                'And a ServerFailure occurs',
                setUp: () {
                  when(
                    () => mockArticlesUseCases.getArticles(source: 'abc-news'),
                  ).thenAnswer(
                    (invocation) => Future.value(
                      Left<Failure, ArticlesEntity>(
                        ServerFailure(),
                      ),
                    ),
                  );
                },
                build: () => ArticlesCubit(
                  articlesUseCases: mockArticlesUseCases,
                ),
                act: (cubit) => cubit.articlesRequest(source: 'abc-news'),
                expect: () => <ArticlesState>[
                  const ArticlesLoadingState(),
                  ArticlesErrorState(
                    message: HSStrings.serverFailureMessage,
                    failure: ServerFailure(),
                  ),
                ],
              );

              blocTest(
                'And an EmptyFailure occurs',
                setUp: () {
                  when(
                    () => mockArticlesUseCases.getArticles(source: 'abc-news'),
                  ).thenAnswer(
                    (invocation) => Future.value(
                      Left<Failure, ArticlesEntity>(
                        EmptyFailure(),
                      ),
                    ),
                  );
                },
                build: () => ArticlesCubit(
                  articlesUseCases: mockArticlesUseCases,
                ),
                act: (cubit) => cubit.articlesRequest(source: 'abc-news'),
                expect: () => <ArticlesState>[
                  const ArticlesLoadingState(),
                  ArticlesErrorState(
                    message: HSStrings.emptyFailureMessage,
                    failure: EmptyFailure(),
                  ),
                ],
              );

              blocTest(
                'And a GeneralFailure occurs',
                setUp: () {
                  when(
                    () => mockArticlesUseCases.getArticles(source: 'abc-news'),
                  ).thenAnswer(
                    (invocation) => Future.value(
                      Left<Failure, ArticlesEntity>(
                        GeneralFailure(),
                      ),
                    ),
                  );
                },
                build: () => ArticlesCubit(
                  articlesUseCases: mockArticlesUseCases,
                ),
                act: (cubit) => cubit.articlesRequest(source: 'abc-news'),
                expect: () => <ArticlesState>[
                  const ArticlesLoadingState(),
                  ArticlesErrorState(
                    message: HSStrings.generalFailureMessage,
                    failure: GeneralFailure(),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}
