part of 'operations_bloc.dart';

abstract class OperationsState extends Equatable {
  const OperationsState();

  @override
  List<Object> get props => [];
}

class OperationsInitial extends OperationsState {}

class LoadingState extends OperationsState {}

class SuccessState extends OperationsState {
  final String successMessage;
  const SuccessState({required this.successMessage});

  @override
  List<Object> get props => [successMessage];
}

class FailState extends OperationsState {
  final String failMessage;
  const FailState({ required this.failMessage});

  @override
  List<Object> get props => [failMessage];
}
