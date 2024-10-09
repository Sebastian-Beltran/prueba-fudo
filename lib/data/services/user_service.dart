import 'package:either_dart/either.dart';
import 'package:prueba_fudo/data/models/user_model.dart';

abstract class UserService {
  Future<Either<String, List<UserModel>>> getUsers();
}
