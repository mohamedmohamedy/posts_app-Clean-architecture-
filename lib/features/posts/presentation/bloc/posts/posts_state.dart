part of 'posts_bloc.dart';


abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<PostEntity> posts;
  const LoadedPostsState({required this.posts});

   @override
  List<Object> get props => [posts];
}

class ErrorState extends PostsState {
  final String errorMessage;
  const ErrorState({required this.errorMessage});
   @override
  List<Object> get props => [errorMessage];

}
