import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/data/models/user_model.dart';
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

  Future<void> login(UserModel user) async {
    if (user.userName == 'challenge@fudo' && user.password == 'password') {
      //TODO Show snackbar correcto ingreso
    } else {
      //TODO Show snackbar error
    }
  }
}
