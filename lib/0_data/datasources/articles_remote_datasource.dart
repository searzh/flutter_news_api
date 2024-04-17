import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../2_application/core/utils/keys.dart';
import '../exceptions/exceptions.dart';
import '../models/articles_model.dart';

abstract class ArticlesRemoteDatasource {
  Future<ArticlesModel> getArticlesFromApi({required String source});
}

class ArticlesRemoteDatasourceImpl implements ArticlesRemoteDatasource {
  const ArticlesRemoteDatasourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<ArticlesModel> getArticlesFromApi({
    required String source,
  }) async {
    final response = await client.get(
      Uri.parse(
        'https://newsapi.org/v2/everything?sources=$source&apiKey=${HSKeys.apiKey}',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseBody = json.decode(response.body);

    return ArticlesModel.fromJson(responseBody);
  }
}
