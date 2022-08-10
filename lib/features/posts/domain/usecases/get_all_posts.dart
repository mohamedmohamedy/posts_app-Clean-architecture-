import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post_entitiy.dart';
import '../repositories/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<PostEntity>>> call() async {
    return repository.getAllPosts();
  }
}
