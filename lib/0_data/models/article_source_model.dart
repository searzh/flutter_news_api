import 'package:equatable/equatable.dart';

import '../../1_domain/entities/article_source_entity.dart';

class ArticleSourceModel extends ArticleSourceEntity with EquatableMixin {
  const ArticleSourceModel({
    required super.id,
    required super.name,
  });

  factory ArticleSourceModel.fromJson(Map<String, dynamic> json) {
    return ArticleSourceModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
