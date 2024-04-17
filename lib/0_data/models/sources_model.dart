import 'package:equatable/equatable.dart';

import '../../1_domain/entities/source_entity.dart';
import '../../1_domain/entities/sources_entity.dart';
import 'source_model.dart';

class SourcesModel extends SourcesEntity with EquatableMixin {
  SourcesModel({required super.status, required super.sources});

  factory SourcesModel.fromJson(Map<String, dynamic> json) {
    return SourcesModel(
      status: json['status'],
      sources: List<SourceEntity>.from(
        json['sources'].map((jsonSources) => SourceModel.fromJson(jsonSources)),
      ),
    );
  }
}
