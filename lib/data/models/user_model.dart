import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.userName,
    required this.password,
  });
  final String userName;
  final String password;

  @override
  List<Object?> get props => [
        userName,
        password,
      ];
}
