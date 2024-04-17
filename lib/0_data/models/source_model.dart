import 'package:equatable/equatable.dart';

import '../../1_domain/entities/source_entity.dart';

class SourceModel extends SourceEntity with EquatableMixin {
  const SourceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.url,
    required super.category,
    required super.language,
    required super.country,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
    );
  }
}
