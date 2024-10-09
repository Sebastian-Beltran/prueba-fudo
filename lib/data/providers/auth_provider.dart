import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/constants/palette.dart';
import 'package:prueba_fudo/data/models/user_auth_model.dart';
import 'package:prueba_fudo/presentation/state/auth_state.dart';

final authProvider =
    StateNotifierProvider<PostNotifier, AuthState>(PostNotifier.fromRef);

class PostNotifier extends StateNotifier<AuthState> {
  PostNotifier({
    required this.ref,
  }) : super(AuthState.initial());

  factory PostNotifier.fromRef(Ref ref) {
    return PostNotifier(
      ref: ref,
    );
  }
  final Ref ref;

  void resetState() => state = AuthState.initial();

  Future<void> login(UserAuth user, BuildContext context) async {
    // state = state.copyWith(
    //   isAuthenticated: true,
    // );
    // state.isAuthenticated ? Navigator.pushNamed(context, '/posts') : null;

    if (user.userName == 'challenge@fudo' && user.password == 'password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Ingreso correcto'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Palette.green,
        ),
      );
      state = state.copyWith(
        isAuthenticated: true,
      );
      state.isAuthenticated ? Navigator.pushNamed(context, '/posts') : null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Credenciales incorrectas'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Palette.red,
        ),
      );
      state = state.copyWith(
        isAuthenticated: false,
      );
    }
  }
}
