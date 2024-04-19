import 'package:dartz/dartz.dart';
import 'package:flutter_challenge_hs/0_data/repositories/sources_repo_impl.dart';
import 'package:flutter_challenge_hs/1_domain/entities/source_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/sources_entity.dart';
import 'package:flutter_challenge_hs/1_domain/failures/failures.dart';
import 'package:flutter_challenge_hs/1_domain/usecases/sources_usecases.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'sources_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SourcesRepoImpl>()])
void main() {
  group(
    'SourcesUseCases',
    () {
      final mockSourcesRepoImpl = MockSourcesRepoImpl();

      final sourcesUseCaseUnderTest = SourcesUseCases(
        sourcesRepo: mockSourcesRepoImpl,
      );

      group(
        'Should return SourcesEntity',
        () {
          test('When SourcesRepoImpl returns SourcesModel', () async {
            when(mockSourcesRepoImpl.getSourcesFromDatasource()).thenAnswer(
              (realInvocation) => Future.value(const Right(
                SourcesEntity(
                  status: 'ok',
                  sources: [
                    SourceEntity(
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
              )),
            );

            final result = await sourcesUseCaseUnderTest.getSources();

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
              const Right<Failure, SourcesEntity>(
                SourcesEntity(
                  status: 'ok',
                  sources: [
                    SourceEntity(
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

            verify(
              mockSourcesRepoImpl.getSourcesFromDatasource(),
            ).called(1);

            verifyNoMoreInteractions(mockSourcesRepoImpl);
          });
        },
      );

      group(
        'Should return Left with',
        () {
          test(
            'A ServerFailure',
            () async {
              when(mockSourcesRepoImpl.getSourcesFromDatasource()).thenAnswer(
                (realInvocation) => Future.value(Left(
                  ServerFailure(),
                )),
              );

              final result = await sourcesUseCaseUnderTest.getSources();

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
                Left<Failure, SourcesEntity>(ServerFailure()),
              );

              verify(
                mockSourcesRepoImpl.getSourcesFromDatasource(),
              ).called(1);

              verifyNoMoreInteractions(mockSourcesRepoImpl);
            },
          );

          test(
            'A GeneralFailure',
            () async {
              when(mockSourcesRepoImpl.getSourcesFromDatasource()).thenAnswer(
                (realInvocation) => Future.value(Left(
                  GeneralFailure(),
                )),
              );

              final result = await sourcesUseCaseUnderTest.getSources();

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
                Left<Failure, SourcesEntity>(GeneralFailure()),
              );

              verify(
                mockSourcesRepoImpl.getSourcesFromDatasource(),
              ).called(1);

              verifyNoMoreInteractions(mockSourcesRepoImpl);
            },
          );
        },
      );
    },
  );
}
