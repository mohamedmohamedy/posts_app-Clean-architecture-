part of 'operations_bloc.dart';

abstract class OperationsEvent extends Equatable {
  const OperationsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends OperationsEvent {
  final PostEntity post;
  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends OperationsEvent {
  final PostEntity post;
  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}
class DeletePostEvent extends OperationsEvent {
  final int postId;

  const DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
