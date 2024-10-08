import 'package:either_dart/either.dart';
import 'package:prueba_fudo/data/models/post_model.dart';

abstract class PostService {
  Future<Either<String, List<Post>>> getPostList();
}
