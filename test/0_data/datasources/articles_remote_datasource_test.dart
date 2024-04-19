import 'package:flutter_challenge_hs/0_data/datasources/articles_remote_datasource.dart';
import 'package:flutter_challenge_hs/0_data/exceptions/exceptions.dart';
import 'package:flutter_challenge_hs/0_data/models/article_model.dart';
import 'package:flutter_challenge_hs/0_data/models/article_source_model.dart';
import 'package:flutter_challenge_hs/0_data/models/articles_model.dart';
import 'package:flutter_challenge_hs/2_application/core/utils/keys.dart';

import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';

import 'articles_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group(
    'ArticlesRemoteDatasource',
    () {
      final mockClient = MockClient();

      final articlesRemoteDataSourceUnderTest = ArticlesRemoteDatasourceImpl(
        client: mockClient,
      );

      group(
        'Should return ArticlesModel',
        () {
          test(
            'When Client response was 200 and has valid data',
            () async {
              const responseBody =
                  '{"status":"ok","totalResults":1,"articles":[{"source":{"id":"politico","name":"Politico"},"author":"Steven Shepard","title":"The polls are suggesting a huge shift in the electorate. Are they right?","description":"It\'s a significant reversal from recent history: President Joe Biden is struggling with young voters but performing better than most Democrats with older...","url":"https://www.politico.com/news/2024/04/07/voter-age-biden-trump-2024-election-00150923","urlToImage":"https://s.yimg.com/ny/api/res/1.2/b.0HLYOqo7b4SgeB0Qf4hg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTEyMDA7aD04MDA-/https://media.zenfs.com/en/politico_453/62d1b66fdef0ab293b4b54b4585c9b57","publishedAt":"2024-04-07T11:00:00Z","content":"Example content"}]}';

              when(mockClient.get(
                Uri.parse(
                  'https://newsapi.org/v2/everything?sources=abc-news&apiKey=${HSKeys.apiKey}',
                ),
                headers: {
                  'Content-Type': 'application/json',
                  'Access-Control-Allow-Origin': '*',
                },
              )).thenAnswer(
                (realInvocation) => Future.value(Response(responseBody, 200)),
              );

              final result =
                  await articlesRemoteDataSourceUnderTest.getArticlesFromApi(
                source: 'abc-news',
              );

              expect(
                result,
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
              );
            },
          );
        },
      );

      group(
        'Should throw ',
        () {
          test('A ServerException when Client response was not 200', () {
            when(mockClient.get(
              Uri.parse(
                'https://newsapi.org/v2/everything?sources=abc-news&apiKey=${HSKeys.apiKey}',
              ),
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
              },
            )).thenAnswer(
              (realInvocation) => Future.value(Response('', 201)),
            );

            expect(
              () => articlesRemoteDataSourceUnderTest.getArticlesFromApi(
                source: 'abc-news',
              ),
              throwsA(isA<ServerException>()),
            );
          });

          test('A TypeError when Client response was 200 and has invalid data',
              () {
            const responseBody = '{"status":"Wrong data"}';

            when(mockClient.get(
              Uri.parse(
                'https://newsapi.org/v2/everything?sources=abc-news&apiKey=${HSKeys.apiKey}',
              ),
              headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
              },
            )).thenAnswer(
              (realInvocation) => Future.value(Response(responseBody, 200)),
            );

            expect(
              () => articlesRemoteDataSourceUnderTest.getArticlesFromApi(
                source: 'abc-news',
              ),
              throwsA(isA<TypeError>()),
            );
          });
        },
      );
    },
  );
}
