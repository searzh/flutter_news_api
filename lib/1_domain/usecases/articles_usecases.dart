import 'package:dartz/dartz.dart';

import '../entities/articles_entity.dart';
import '../failures/failures.dart';
import '../repositories/articles_repo.dart';

class ArticlesUseCases {
  const ArticlesUseCases({required this.articlesRepo});

  final ArticlesRepo articlesRepo;

  Future<Either<Failure, ArticlesEntity>> getArticles({
    required String source,
  }) async {
    return articlesRepo.getArticlesFromDataSource(source: source);
  }
}
