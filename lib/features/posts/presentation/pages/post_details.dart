import 'package:flutter/material.dart';
import '../../../../core/strings/bloc_strings.dart';
import '../../domain/entities/post_entitiy.dart';

import '../widgets/post_details_widgets/post_details_widget.dart';

class PostDetailsScreen extends StatelessWidget {
  static const String routeName = RoutesName.postDetailsRoute;

  const PostDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostEntity post =
        ModalRoute.of(context)!.settings.arguments as PostEntity;
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(post, context),
    );
  }

//_______________________________Helper functions___________________________________
  AppBar _getAppBar() {
    return AppBar(
        centerTitle: true,
        title: const Text(
          PublicStrings.postDetailTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }

  Widget _getBody(PostEntity post, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailsWidget(post: post),
      ),
    );
  }
}
