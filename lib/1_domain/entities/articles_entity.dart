import 'package:equatable/equatable.dart';

import 'article_entity.dart';

class ArticlesEntity extends Equatable {
  const ArticlesEntity({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<ArticleEntity> articles;

  @override
  List<Object?> get props => [
        status,
        articles,
      ];
}
