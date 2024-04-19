import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_challenge_hs/0_data/datasources/articles_remote_datasource.dart';
import 'package:flutter_challenge_hs/0_data/models/article_model.dart';
import 'package:flutter_challenge_hs/0_data/models/article_source_model.dart';
import 'package:flutter_challenge_hs/0_data/models/articles_model.dart';
import 'package:flutter_challenge_hs/0_data/repositories/articles_repo_impl.dart';
import 'package:flutter_challenge_hs/1_domain/failures/failures.dart';
import 'package:flutter_challenge_hs/0_data/exceptions/exceptions.dart';
import 'package:flutter_challenge_hs/1_domain/entities/articles_entity.dart';

import 'articles_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArticlesRemoteDatasourceImpl>()])
void main() {
  group(
    'ArticlesRepoImpl',
    () {
      final mockArticlesRemoteDatasource = MockArticlesRemoteDatasourceImpl();

      final articleRepoImplUnderTest = ArticlesRepoImpl(
        articlesRemoteDatasource: mockArticlesRemoteDatasource,
      );

      group(
        'Should return an ArticlesEntity',
        () {
          test(
            'When ArticlesRemoteDatasource returns an ArticlesModel',
            () async {
              when(
                mockArticlesRemoteDatasource.getArticlesFromApi(
                    source: 'abc-news'),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  ArticlesModel(
                    status: 'ok',
                    totalResults: 1,
                    articles: const [
                      ArticleModel(
                        source: ArticleSourceModel(
                          id: 'politico',
                          name: 'Politico',
                        ),
                        author: 'Steven Shepard',
                        title:
                            'The polls are suggesting a huge shift in the electorate. Are they right?',
                        description:
                            "It's a significant reversal from recent history: President Joe Biden is struggling with young voters but performing better than most Democrats with older...",
                        url:
                            'https://www.politico.com/news/2024/04/07/voter-age-biden-trump-2024-election-00150923',
                        urlToImage:
                            'https://s.yimg.com/ny/api/res/1.2/b.0HLYOqo7b4SgeB0Qf4hg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/politico_453/62d1b66fdef0ab293b4b54b4585c9b57',
                        publishedAt: '2024-04-07T11:00:00Z',
                        content: 'Example content',
                      ),
                    ],
                  ),
                ),
              );

              final result = await articleRepoImplUnderTest
                  .getArticlesFromDataSource(source: 'abc-news');

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
                Right<Failure, ArticlesModel>(
                  ArticlesModel(
                    status: 'ok',
                    totalResults: 1,
                    articles: const [
                      ArticleModel(
                        source: ArticleSourceModel(
                          id: 'politico',
                          name: 'Politico',
                        ),
                        author: 'Steven Shepard',
                        title:
                            'The polls are suggesting a huge shift in the electorate. Are they right?',
                        description:
                            "It's a significant reversal from recent history: President Joe Biden is struggling with young voters but performing better than most Democrats with older...",
                        url:
                            'https://www.politico.com/news/2024/04/07/voter-age-biden-trump-2024-election-00150923',
                        urlToImage:
                            'https://s.yimg.com/ny/api/res/1.2/b.0HLYOqo7b4SgeB0Qf4hg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/politico_453/62d1b66fdef0ab293b4b54b4585c9b57',
                        publishedAt: '2024-04-07T11:00:00Z',
                        content: 'Example content',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

      group('Should return left with', () {
        test('A ServerFailure when a ServerExecption occurs', () async {
          when(mockArticlesRemoteDatasource.getArticlesFromApi(
                  source: 'abc-news'))
              .thenThrow(
            ServerException(),
          );

          final result =
              await articleRepoImplUnderTest.getArticlesFromDataSource(
            source: 'abc-news',
          );

          expect(
            result.isLeft(),
            true,
          );

          expect(
            result.isRight(),
            false,
          );

          expect(
            result,
            Left<Failure, ArticlesEntity>(ServerFailure()),
          );
        });

        test('A GeneralFailure on all other Exceptions', () async {
          when(mockArticlesRemoteDatasource.getArticlesFromApi(
                  source: 'abc-news'))
              .thenThrow(
            const SocketException('Test'),
          );

          final result =
              await articleRepoImplUnderTest.getArticlesFromDataSource(
            source: 'abc-news',
          );

          expect(
            result.isLeft(),
            true,
          );

          expect(
            result.isRight(),
            false,
          );

          expect(
            result,
            Left<Failure, ArticlesEntity>(GeneralFailure()),
          );
        });
      });
    },
  );
}
