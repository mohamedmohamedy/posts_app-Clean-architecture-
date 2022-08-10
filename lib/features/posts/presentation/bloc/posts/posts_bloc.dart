import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/bloc_strings.dart';
import '../../../domain/entities/post_entitiy.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        emit(LoadingPostsState());
        final loadedPosts = await getAllPosts();
        emit(_getState(loadedPosts));
      }
      if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final loadedPosts = await getAllPosts();
        emit(_getState(loadedPosts));
      }
    });
  }

  PostsState _getState(Either<Failure, List<PostEntity>> either) {
    return either.fold(
      (failure) => ErrorState(errorMessage: _getErrorMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsMessages.serverFailure;
      case EmptyCacheFailure:
        return ErrorsMessages.cacheFailure;
      case OfflineFailure:
        return ErrorsMessages.offlineFailure;
      default:
        return ErrorsMessages.unknownFailure;
    }
  }
}
