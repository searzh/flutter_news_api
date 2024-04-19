import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:flutter_challenge_hs/0_data/repositories/articles_repo_impl.dart';
import 'package:flutter_challenge_hs/1_domain/entities/article_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/article_source_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/articles_entity.dart';
import 'package:flutter_challenge_hs/1_domain/failures/failures.dart';
import 'package:flutter_challenge_hs/1_domain/usecases/articles_usecases.dart';

import 'articles_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArticlesRepoImpl>()])
void main() {
  group(
    'ArticlesUseCases',
    () {
      final mockArticlesRepoImpl = MockArticlesRepoImpl();

      final articleUseCaseUnderTest = ArticlesUseCases(
        articlesRepo: mockArticlesRepoImpl,
      );

      group(
        'Should return ArticlesEntity',
        () {
          test('When ArticlesRepoImpl returns ArticlesModel', () async {
            when(mockArticlesRepoImpl.getArticlesFromDataSource(
              source: 'abc-news',
            )).thenAnswer(
              (realInvocation) => Future.value(
                const Right(
                  ArticlesEntity(
                    status: 'ok',
                    totalResults: 2,
                    articles: [
                      ArticleEntity(
                        source: ArticleSourceEntity(
                          id: 'abc-news',
                          name: 'ABC News',
                        ),
                        author: 'Jon Doe',
                        title: 'Breaking news',
                        description: 'Example description',
                        url: 'https://example.com/',
                        urlToImage: 'https://example.com/',
                        publishedAt: '2023-04-18T12:00:00Z',
                        content: 'Example content',
                      ),
                    ],
                  ),
                ),
              ),
            );

            final result = await articleUseCaseUnderTest.getArticles(
              source: 'abc-news',
            );

            expect(
              result.isLeft(),
              false,
            );

            expect(
              result.isRight(),
              true,
            );

            expect(
              result,
              const Right<Failure, ArticlesEntity>(
                ArticlesEntity(
                  status: 'ok',
                  totalResults: 2,
                  articles: [
                    ArticleEntity(
                      source: ArticleSourceEntity(
                        id: 'abc-news',
                        name: 'ABC News',
                      ),
                      author: 'Jon Doe',
                      title: 'Breaking news',
                      description: 'Example description',
                      url: 'https://example.com/',
                      urlToImage: 'https://example.com/',
                      publishedAt: '2023-04-18T12:00:00Z',
                      content: 'Example content',
                    ),
                  ],
                ),
              ),
            );

            verify(
              mockArticlesRepoImpl.getArticlesFromDataSource(
                source: 'abc-news',
              ),
            ).called(1);

            verifyNoMoreInteractions(mockArticlesRepoImpl);
          });
        },
      );

      group(
        'Should return Left with',
        () {
          test(
            'A ServerFailure',
            () async {
              when(mockArticlesRepoImpl.getArticlesFromDataSource(
                source: 'abc-news',
              )).thenAnswer(
                (realInvocation) => Future.value(Left(
                  ServerFailure(),
                )),
              );

              final result = await articleUseCaseUnderTest.getArticles(
                source: 'abc-news',
              );

              expect(
                result.isRight(),
                false,
              );

              expect(
                result.isLeft(),
                true,
              );

              expect(
                result,
                Left<Failure, ArticlesEntity>(ServerFailure()),
              );

              verify(
                mockArticlesRepoImpl.getArticlesFromDataSource(
                  source: 'abc-news',
                ),
              ).called(1);

              verifyNoMoreInteractions(mockArticlesRepoImpl);
            },
          );

          test(
            'A GeneralFailure',
            () async {
              when(mockArticlesRepoImpl.getArticlesFromDataSource(
                source: 'abc-news',
              )).thenAnswer(
                (realInvocation) => Future.value(Left(
                  GeneralFailure(),
                )),
              );

              final result = await articleUseCaseUnderTest.getArticles(
                source: 'abc-news',
              );

              expect(
                result.isRight(),
                false,
              );

              expect(
                result.isLeft(),
                true,
              );

              expect(
                result,
                Left<Failure, ArticlesEntity>(GeneralFailure()),
              );

              verify(
                mockArticlesRepoImpl.getArticlesFromDataSource(
                  source: 'abc-news',
                ),
              ).called(1);

              verifyNoMoreInteractions(mockArticlesRepoImpl);
            },
          );
        },
      );
    },
  );
}
