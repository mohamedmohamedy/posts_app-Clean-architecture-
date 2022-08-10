import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post_entitiy.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(PostEntity post);
  Future<Either<Failure, Unit>> updatePost(PostEntity post);
  Future<Either<Failure, Unit>> deletePost(int id);
}
