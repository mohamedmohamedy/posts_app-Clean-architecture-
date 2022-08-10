import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/post_entitiy.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/bloc_strings.dart';
import '../../../domain/usecases/add_post.dart';

part 'operations_event.dart';
part 'operations_state.dart';

class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;

  OperationsBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(OperationsInitial()) {
    on<OperationsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingState());
        final response = await addPost(event.post);
        emit(_getState(response, SuccessMessages.adding));
      } else if (event is UpdatePostEvent) {
        emit(LoadingState());
        final response = await updatePost(event.post);
        emit(_getState(response, SuccessMessages.updating));
      } else if (event is DeletePostEvent) {
        emit(LoadingState());
        final response = await deletePost(event.postId);
        emit(_getState(response, SuccessMessages.deleting));
      }
    });
  }

//________________________________Helping functions_____________________________
  OperationsState _getState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (fail) => FailState(failMessage: _getErrorMessage(fail)),
      (success) => SuccessState(successMessage: message),
    );
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsMessages.serverFailure;
      case OfflineFailure:
        return ErrorsMessages.offlineFailure;
      default:
        return ErrorsMessages.unknownFailure;
    }
  }
}
