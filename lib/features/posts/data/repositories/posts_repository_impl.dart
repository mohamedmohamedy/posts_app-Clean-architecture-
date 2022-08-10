import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/post_model.dart';
import '../../domain/entities/post_entitiy.dart';
import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/posts_repository.dart';

typedef FutureFunction = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final PostsLocalDataSource localDataSource;
  final PostsRemoteDataSource remoteDataSource;
  final NetworkInfo deviceStatus;

  PostsRepositoryImpl(
      this.localDataSource, this.remoteDataSource, this.deviceStatus);

  @override
  Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
    if (await deviceStatus.isConnected) {
      try {
        final posts = await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(posts);
        return Right(posts);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final posts = await localDataSource.getCachedPosts();
        return Right(posts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntity post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() => remoteDataSource.editPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => remoteDataSource.deletePost(id));
  }

  Future<Either<Failure, Unit>> _getMessage(
      FutureFunction wantedMethod) async {
    if (await deviceStatus.isConnected) {
      try {
        await wantedMethod();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
