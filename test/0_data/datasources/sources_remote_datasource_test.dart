import 'package:flutter_challenge_hs/0_data/datasources/sources_remote_datasource.dart';
import 'package:flutter_challenge_hs/0_data/models/source_model.dart';
import 'package:flutter_challenge_hs/0_data/models/sources_model.dart';
import 'package:flutter_challenge_hs/2_application/core/utils/keys.dart';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'articles_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group(
    'SourcesRemoteDatasource',
    () {
      final mockClient = MockClient();

      final sourcesRemoteDataSourceUnderTest = SourcesRemoteDatasourceImpl(
        client: mockClient,
      );

      group(
        'Should return SourcesModel',
        () {
          test('When Client response was 200 and has valid data', () async {
            String responseBody =
                '{"status":"ok","sources":[{"id":"abc-news","name":"ABC News","description":"Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.","url":"https://abcnews.go.com","category":"general","language":"en","country":"us"}]}';

            when(mockClient.get(
              Uri.parse(
                'https://newsapi.org/v2/top-headlines/sources?apiKey=${HSKeys.apiKey}',
              ),
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
              },
            )).thenAnswer(
              (realInvocation) => Future.value(Response(responseBody, 200)),
            );

            final result =
                await sourcesRemoteDataSourceUnderTest.getSourcesFromApi();

            expect(
              result,
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
            );
          });
        },
      );
    },
  );
}
