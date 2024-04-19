import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:flutter_challenge_hs/0_data/datasources/sources_remote_datasource.dart';
import 'package:flutter_challenge_hs/0_data/exceptions/exceptions.dart';
import 'package:flutter_challenge_hs/0_data/models/source_model.dart';
import 'package:flutter_challenge_hs/0_data/models/sources_model.dart';
import 'package:flutter_challenge_hs/0_data/repositories/sources_repo_impl.dart';
import 'package:flutter_challenge_hs/1_domain/entities/sources_entity.dart';
import 'package:flutter_challenge_hs/1_domain/failures/failures.dart';

import 'sources_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SourcesRemoteDatasourceImpl>()])
void main() {
  group(
    'SourcesRepoImpl',
    () {
      final mockSourcesRemoteDatasource = MockSourcesRemoteDatasourceImpl();

      final sourcesRepoImplUnderTest = SourcesRepoImpl(
        sourcesRemoteDatasource: mockSourcesRemoteDatasource,
      );

      group(
        'Should return a SourcesEntity',
        () {
          test(
            'When SourcesRemoteDatasource returns a SourcesModel',
            () async {
              when(mockSourcesRemoteDatasource.getSourcesFromApi()).thenAnswer(
                (realInvocation) => Future.value(
                  SourcesModel(
                    status: 'ok',
                    sources: const [
                      SourceModel(
                        id: 'abc-news',
                        name: 'ABC News',
                        description:
                            'Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.',
                        url: 'https://abcnews.go.com',
                        category: 'general',
                        language: 'en',
                        country: 'us',
                      ),
                    ],
                  ),
                ),
              );

              final result =
                  await sourcesRepoImplUnderTest.getSourcesFromDatasource();

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
                Right<Failure, SourcesModel>(
                  SourcesModel(
                    status: 'ok',
                    sources: const [
                      SourceModel(
                        id: 'abc-news',
                        name: 'ABC News',
                        description:
                            'Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.',
                        url: 'https://abcnews.go.com',
                        category: 'general',
                        language: 'en',
                        country: 'us',
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
          when(mockSourcesRemoteDatasource.getSourcesFromApi()).thenThrow(
            ServerException(),
          );

          final result =
              await sourcesRepoImplUnderTest.getSourcesFromDatasource();

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
            Left<Failure, SourcesEntity>(ServerFailure()),
          );
        });

        test('A GeneralFailure on all other Exceptions', () async {
          when(mockSourcesRemoteDatasource.getSourcesFromApi()).thenThrow(
            const SocketException('Test'),
          );

          final result =
              await sourcesRepoImplUnderTest.getSourcesFromDatasource();

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
            Left<Failure, SourcesEntity>(GeneralFailure()),
          );
        });
      });
    },
  );
}
