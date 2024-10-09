import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/data/services/user_service.dart';
import 'package:prueba_fudo/data/services/user_service_impl.dart';
import 'package:prueba_fudo/presentation/state/user_state.dart';

final userProvider =
    StateNotifierProvider<UserNotifier, UserState>(UserNotifier.fromRef);

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier({
    required this.userService,
    required this.ref,
  }) : super(UserState.initial());

  factory UserNotifier.fromRef(Ref ref) {
    return UserNotifier(
      userService: ref.read(userServiceProvider),
      ref: ref,
    );
  }
  final UserService userService;
  final Ref ref;

  void resetState() => state = UserState.initial();

  Future<void> getUsers() async {
    state = state.copyWith(isLoading: true);
    final res = await userService.getUsers();
    state = state.copyWith(isLoading: false);
    res.fold(
      (left) => state = state.copyWith(
        isError: left,
        isInitState: false,
      ),
      (right) => state = state.copyWith(
        users: right,
        isInitState: false,
      ),
    );
  }
}
