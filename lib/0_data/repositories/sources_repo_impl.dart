import 'package:dartz/dartz.dart';

import '../../1_domain/entities/sources_entity.dart';
import '../../1_domain/failures/failures.dart';
import '../../1_domain/repositories/sources_repo.dart';
import '../datasources/sources_remote_datasource.dart';
import '../exceptions/exceptions.dart';

class SourcesRepoImpl implements SourcesRepo {
  const SourcesRepoImpl({required this.sourcesRemoteDatasource});

  final SourcesRemoteDatasource sourcesRemoteDatasource;

  @override
  Future<Either<Failure, SourcesEntity>> getSourcesFromDatasource() async {
    try {
      final result = await sourcesRemoteDatasource.getSourcesFromApi();

      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
