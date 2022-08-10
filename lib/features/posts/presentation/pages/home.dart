import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_update.dart';

import '../../../../core/strings/bloc_strings.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import '../widgets/home_widgets/error_message_widget.dart';
import '../widgets/home_widgets/posts_widget.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = RoutesName.homeRoute;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
      floatingActionButton: _getFAB(context),
    );
  }

//______________________________________________________________________________
  AppBar _getAppBar() => AppBar(title: const Text('Posts'));

  Widget _getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: ((context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
                onRefresh: () => _getRefresh(context),
                child: PostsWidget(posts: state.posts));
          } else if (state is ErrorState) {
            return ErrorMessageWidget(message: state.errorMessage);
          }
          return const LoadingWidget();
        }),
      ),
    );
  }

  FloatingActionButton _getFAB(BuildContext context) => FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AddOrUpdateScreen.routeName),
        child: const Icon(Icons.add),
      );

  Future<void> _getRefresh(context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
