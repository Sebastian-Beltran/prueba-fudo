import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/api/request_handler.dart';
import 'package:prueba_fudo/data/models/post_model.dart';
import 'package:prueba_fudo/data/services/post_service.dart';

final postServiceProvider =
    Provider.autoDispose<PostService>(PostServiceImpl.fromRef);

class PostServiceImpl implements PostService {
  PostServiceImpl({
    required this.client,
  });

  factory PostServiceImpl.fromRef(Ref ref) {
    return PostServiceImpl(
      client: ref.read(requestHandlerProvider),
    );
  }

  final RequestHandler client;

  @override
  Future<Either<String, List<Post>>> getPostList({int? userId}) async {
    try {
      String path;
      if (userId == null) {
        path = '/posts';
      } else {
        path = '/posts?userId=$userId';
      }
      final res = await client.performGet(path);
      final body = json.decode(
        res.body.trim(),
      );

      final listPost = List<Post>.from(body
          .map((dynamic item) => Post.fromJson(item as Map<String, dynamic>)));
      return Right(
        listPost,
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<String> createPost({required Post post}) async {
    try {
      const path = '/posts';
      final body = <String, dynamic>{
        'title': post.title,
        'body': post.body,
        'userId': post.userId,
      };
      await client.performPost(path, body);
      return 'Post creado correctamente';
    } catch (e) {
      return e.toString();
    }
  }
}
