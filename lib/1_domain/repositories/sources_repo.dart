import 'package:dartz/dartz.dart';

import '../entities/sources_entity.dart';
import '../failures/failures.dart';

abstract class SourcesRepo {
  Future<Either<Failure, SourcesEntity>> getSourcesFromDatasource();
}
