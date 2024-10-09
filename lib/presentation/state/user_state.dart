import 'package:equatable/equatable.dart';
import 'package:prueba_fudo/data/models/user_model.dart';

final class UserState extends Equatable {
  const UserState({
    this.users,
    this.isLoading = false,
    this.isInitState = true,
    this.isError,
  });

  final List<UserModel>? users;
  final bool isLoading;
  final String? isError;
  final bool isInitState;

  factory UserState.initial() => const UserState();

  UserState copyWith({
    List<UserModel>? users,
    bool? isLoading,
    String? isError,
    bool? isInitState,
  }) {
    return UserState(
      users: users ?? this.users,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isInitState: isInitState ?? this.isInitState,
    );
  }

  @override
  List<Object?> get props => [
        users,
        isError,
        isInitState,
        isLoading,
      ];
}
