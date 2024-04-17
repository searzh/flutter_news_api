import 'package:dartz/dartz.dart';

import '../entities/sources_entity.dart';
import '../failures/failures.dart';
import '../repositories/sources_repo.dart';

class SourcesUseCases {
  const SourcesUseCases({required this.sourcesRepo});

  final SourcesRepo sourcesRepo;

  Future<Either<Failure, SourcesEntity>> getSources() async {
    return sourcesRepo.getSourcesFromDatasource();
  }
}
