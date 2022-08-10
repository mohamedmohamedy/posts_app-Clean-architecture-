import 'package:dartz/dartz.dart';
import '../entities/post_entitiy.dart';
import '../repositories/posts_repository.dart';

import '../../../../core/errors/failures.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int id) async =>
      repository.deletePost(id);
}
