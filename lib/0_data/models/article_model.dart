import 'package:equatable/equatable.dart';

import '../../1_domain/entities/article_entity.dart';
import '../../2_application/core/utils/functions.dart';
import 'article_source_model.dart';

class ArticleModel extends ArticleEntity with EquatableMixin {
  const ArticleModel({
    required super.source,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
    required super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> escapedJson = escapeQuotes(json);

    return ArticleModel(
      source: ArticleSourceModel.fromJson(json['source']),
      author: escapedJson['author'],
      title: escapedJson['title'],
      description: escapedJson['description'],
      url: escapedJson['url'],
      urlToImage: escapedJson['urlToImage'],
      publishedAt: escapedJson['publishedAt'],
      content: escapedJson['content'],
    );
  }
}
