import 'package:flutter/material.dart';
import '../../pages/post_details.dart';
import '../../../domain/entities/post_entitiy.dart';

class PostsWidget extends StatelessWidget {
  final List<PostEntity> posts;
  const PostsWidget({Key? key, required this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: ((context, index) => ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              posts[index].body,
              style: const TextStyle(fontSize: 16),
            ),
            onTap: () => Navigator.of(context).pushNamed(
                PostDetailsScreen.routeName,
                arguments: posts[index]),
          )),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: posts.length,
    );
  }
}
