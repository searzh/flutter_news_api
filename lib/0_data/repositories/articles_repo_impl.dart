import '../../1_domain/entities/articles_entity.dart';
import '../../1_domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

import '../../1_domain/repositories/articles_repo.dart';
import '../datasources/articles_remote_datasource.dart';
import '../exceptions/exceptions.dart';

class ArticlesRepoImpl implements ArticlesRepo {
  const ArticlesRepoImpl({required this.articlesRemoteDatasource});

  final ArticlesRemoteDatasource articlesRemoteDatasource;

  @override
  Future<Either<Failure, ArticlesEntity>> getArticlesFromDataSource({
    required String source,
  }) async {
    try {
      final result = await articlesRemoteDatasource.getArticlesFromApi(
        source: source,
      );

      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
