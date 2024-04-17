import 'package:dartz/dartz.dart';

import '../entities/articles_entity.dart';
import '../failures/failures.dart';

abstract class ArticlesRepo {
  Future<Either<Failure, ArticlesEntity>> getArticlesFromDataSource({
    required String source,
  });
}
