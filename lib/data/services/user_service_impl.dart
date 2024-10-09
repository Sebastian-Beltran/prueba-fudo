import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/api/request_handler.dart';
import 'package:prueba_fudo/data/models/user_model.dart';
import 'package:prueba_fudo/data/services/user_service.dart';

final userServiceProvider =
    Provider.autoDispose<UserService>(UserServiceImpl.fromRef);

class UserServiceImpl implements UserService {
  UserServiceImpl({
    required this.client,
  });

  factory UserServiceImpl.fromRef(Ref ref) {
    return UserServiceImpl(
      client: ref.read(requestHandlerProvider),
    );
  }

  final RequestHandler client;

  @override
  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      const path = '//users';
      final res = await client.performGet(path);
      final body = json.decode(
        res.body.trim(),
      );

      final listUser = List<UserModel>.from(body.map(
          (dynamic item) => UserModel.fromJson(item as Map<String, dynamic>)));
      return Right(
        listUser,
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
