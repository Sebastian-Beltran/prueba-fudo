import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  const UserAuth({
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
