import 'package:flutter_challenge_hs/1_domain/entities/source_entity.dart';
import 'package:flutter_challenge_hs/1_domain/entities/sources_entity.dart';
import 'package:flutter_challenge_hs/1_domain/failures/failures.dart';
import 'package:flutter_challenge_hs/1_domain/usecases/sources_usecases.dart';
import 'package:flutter_challenge_hs/2_application/core/utils/strings.dart';
import 'package:flutter_challenge_hs/2_application/pages/sources/sources_cubit/sources_cubit.dart';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSourcesUseCases extends Mock implements SourcesUseCases {}

void main() {
  group(
    'SourcesCubit',
    () {
      group(
        'Should emit',
        () {
          MockSourcesUseCases mockSourcesUseCases = MockSourcesUseCases();

          blocTest(
            'Nothing when no method is called',
            build: () => SourcesCubit(sourcesUseCases: mockSourcesUseCases),
            expect: () => <SourcesState>[],
          );

          blocTest(
            '[SourcesLoadingState, SourcesLoadedState] when sourcesRequest() is called',
            setUp: () {
              when(() => mockSourcesUseCases.getSources()).thenAnswer(
                (invocation) => Future.value(
                  const Right<Failure, SourcesEntity>(
                    SourcesEntity(status: 'ok', sources: [
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
                    ]),
                  ),
                ),
              );
            },
            build: () => SourcesCubit(sourcesUseCases: mockSourcesUseCases),
            act: (cubit) => cubit.sourcesRequest(),
            expect: () => <SourcesState>[
              const SourcesLoadingState(),
              const SourcesLoadedState(
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
            ],
          );

          group(
            '[SourcesLoadingState, SourcesErrorState] when sourcesRequest() is called',
            () {
              blocTest(
                'And a ServerFailure occurs',
                setUp: () {
                  when(() => mockSourcesUseCases.getSources()).thenAnswer(
                    (invocation) => Future.value(
                      Left<Failure, SourcesEntity>(
                        ServerFailure(),
                      ),
                    ),
                  );
                },
                build: () => SourcesCubit(sourcesUseCases: mockSourcesUseCases),
                act: (cubit) => cubit.sourcesRequest(),
                expect: () => const <SourcesState>[
                  SourcesLoadingState(),
                  SourcesErrorState(message: HSStrings.serverFailureMessage),
                ],
              );

              blocTest(
                'And an EmptyFailure occurs',
                setUp: () {
                  when(() => mockSourcesUseCases.getSources()).thenAnswer(
                    (invocation) => Future.value(
                      Left<Failure, SourcesEntity>(
                        EmptyFailure(),
                      ),
                    ),
                  );
                },
                build: () => SourcesCubit(sourcesUseCases: mockSourcesUseCases),
                act: (cubit) => cubit.sourcesRequest(),
                expect: () => const <SourcesState>[
                  SourcesLoadingState(),
                  SourcesErrorState(message: HSStrings.emptyFailureMessage),
                ],
              );

              blocTest(
                'And a GeneralFailure occurs',
                setUp: () {
                  when(() => mockSourcesUseCases.getSources()).thenAnswer(
                    (invocation) => Future.value(
                      Left<Failure, SourcesEntity>(
                        GeneralFailure(),
                      ),
                    ),
                  );
                },
                build: () => SourcesCubit(sourcesUseCases: mockSourcesUseCases),
                act: (cubit) => cubit.sourcesRequest(),
                expect: () => const <SourcesState>[
                  SourcesLoadingState(),
                  SourcesErrorState(message: HSStrings.generalFailureMessage),
                ],
              );
            },
          );
        },
      );
    },
  );
}
