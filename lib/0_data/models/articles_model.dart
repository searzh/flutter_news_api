import 'package:equatable/equatable.dart';

import '../../1_domain/entities/article_entity.dart';
import '../../1_domain/entities/articles_entity.dart';
import 'article_model.dart';

class ArticlesModel extends ArticlesEntity with EquatableMixin {
  ArticlesModel({
    required super.status,
    required super.totalResults,
    required super.articles,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<ArticleEntity>.from(
        json['articles'].map(
          (jsonArticles) => ArticleModel.fromJson(jsonArticles),
        ),
      ),
    );
  }
}
