import 'package:equatable/equatable.dart';

import 'source_entity.dart';

class SourcesEntity extends Equatable {
  const SourcesEntity({required this.status, required this.sources});

  final String status;
  final List<SourceEntity> sources;

  @override
  List<Object?> get props => [
        status,
        sources,
      ];
}
