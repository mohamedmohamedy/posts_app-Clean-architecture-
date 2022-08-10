import 'package:flutter/material.dart';

import '../../../domain/entities/post_entitiy.dart';
import 'delete_button.dart';
import 'edit_button.dart';

class PostDetailsWidget extends StatelessWidget {
  final PostEntity post;
  const PostDetailsWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            post.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(post.body),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EditButtonWidget(post: post),
            DeleteButtonWidget(postId: post.id),
          ],
        ),
      ],
    );
  }
}
