import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

const BASE_URL = 'https://jsonplaceholder.typicode.com/posts/';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel post);
  Future<Unit> editPost(PostModel post);
  Future<Unit> deletePost(int id);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final http.Client client;

  PostsRemoteDataSourceImpl(this.client);
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse(BASE_URL),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final List decodedPosts = json.decode(response.body);
      final List<PostModel> postsData = decodedPosts
          .map<PostModel>(
              (decodedPostsList) => PostModel.fromJson(decodedPostsList))
          .toList();
      return postsData;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {'body': post.body, 'title': post.title};

    final response = await client.post(Uri.parse(BASE_URL), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final response = await client.delete(Uri.parse(BASE_URL + id.toString()),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> editPost(PostModel post) async {
    final postId = post.id.toString();
    final body = {'body': post.body, 'title': post.title};

    final response =
        await client.patch(Uri.parse(BASE_URL + postId), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
