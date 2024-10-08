import 'package:equatable/equatable.dart';

final class AuthState extends Equatable {
  const AuthState({
    this.isAuthenticated = false,
  });
  final bool isAuthenticated;

  factory AuthState.initial() => const AuthState();

  AuthState copyWith({
    bool? isAuthenticated,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
        isAuthenticated,
      ];
}
