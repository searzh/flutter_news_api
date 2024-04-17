import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../2_application/core/utils/keys.dart';
import '../exceptions/exceptions.dart';
import '../models/sources_model.dart';

abstract class SourcesRemoteDatasource {
  Future<SourcesModel> getSourcesFromApi();
}

class SourcesRemoteDatasourceImpl implements SourcesRemoteDatasource {
  const SourcesRemoteDatasourceImpl({required this.client});

  final http.Client client;

  @override
  Future<SourcesModel> getSourcesFromApi() async {
    final response = await client.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines/sources?apiKey=${HSKeys.apiKey}',
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

    return SourcesModel.fromJson(responseBody);
  }
}
