import 'package:either_dart/either.dart';
import 'package:prueba_fudo/data/models/post_model.dart';

abstract class PostService {
  Future<Either<String, List<Post>>> getPostList({int? userId});
  Future<String> createPost({required Post post});
}
