import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

const CACHED_DATA = 'CACHED_DATA';

abstract class PostsLocalDataSource {
  Future<Unit> cachePosts(List<PostModel> posts);
  Future<List<PostModel>> getCachedPosts();
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Unit> cachePosts(List<PostModel> posts) async {
    List postsToJson =
        posts.map<Map<String, dynamic>>((post) => post.toJson()).toList();

    await sharedPreferences.setString(CACHED_DATA, json.encode(postsToJson));

    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final cachedPosts = sharedPreferences.getString(CACHED_DATA);
    if (cachedPosts != null) {
      List decodedPosts = json.decode(cachedPosts);
      List<PostModel> postModels = decodedPosts
          .map<PostModel>(
              (decodedPostsJson) => PostModel.fromJson(decodedPostsJson))
          .toList();
      return Future.value(postModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
