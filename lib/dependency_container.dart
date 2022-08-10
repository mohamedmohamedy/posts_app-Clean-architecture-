import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';

import 'features/posts/data/datasources/local_data_source.dart';
import 'features/posts/data/datasources/remote_data_source.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/operations/operations_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Features

  // Posts

  // Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => OperationsBloc(
        addPost: sl(),
        updatePost: sl(),
        deletePost: sl(),
      ));

  //  Use cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(sl(), sl(), sl()));

  // Data Sources
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl(sl()));

  /// Core
  // Network info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///  External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
