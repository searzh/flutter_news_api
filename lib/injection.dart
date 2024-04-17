import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '0_data/datasources/articles_remote_datasource.dart';
import '0_data/datasources/sources_remote_datasource.dart';
import '0_data/repositories/articles_repo_impl.dart';
import '0_data/repositories/sources_repo_impl.dart';
import '1_domain/repositories/articles_repo.dart';
import '1_domain/repositories/sources_repo.dart';
import '1_domain/usecases/articles_usecases.dart';
import '1_domain/usecases/sources_usecases.dart';
import '2_application/pages/articles/cubit/articles_cubit.dart';
import '2_application/pages/details/cubit/details_cubit.dart';
import '2_application/pages/sources/cubit/sources_cubit.dart';

final sl = GetIt.I;

Future<void> init() async {
  // ! application layer
  sl.registerFactory(() => SourcesCubit(sourcesUseCases: sl()));
  sl.registerFactory(() => ArticlesCubit(articlesUseCases: sl()));
  sl.registerFactory(() => DetailsCubit());

  // ! domain layer
  sl.registerFactory(() => SourcesUseCases(sourcesRepo: sl()));
  sl.registerFactory(() => ArticlesUseCases(articlesRepo: sl()));

  // ! data layer
  sl.registerFactory<SourcesRepo>(
    () => SourcesRepoImpl(sourcesRemoteDatasource: sl()),
  );
  sl.registerFactory<SourcesRemoteDatasource>(
    () => SourcesRemoteDatasourceImpl(client: sl()),
  );
  sl.registerFactory<ArticlesRepo>(
    () => ArticlesRepoImpl(articlesRemoteDatasource: sl()),
  );
  sl.registerFactory<ArticlesRemoteDatasource>(
    () => ArticlesRemoteDatasourceImpl(client: sl()),
  );

  // ! externals
  sl.registerFactory(() => http.Client());
}
