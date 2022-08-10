import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post_entitiy.dart';
import '../repositories/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(PostEntity post) async =>
      repository.addPost(post);
}
