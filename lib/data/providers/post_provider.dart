import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/data/services/post_service.dart';
import 'package:prueba_fudo/data/services/post_service_impl.dart';
import 'package:prueba_fudo/presentation/state/post_state.dart';

final postProvider =
    StateNotifierProvider<PostNotifier, PostState>(PostNotifier.fromRef);

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier({
    required this.postService,
    required this.ref,
  }) : super(PostState.initial());

  factory PostNotifier.fromRef(Ref ref) {
    return PostNotifier(
      postService: ref.read(postServiceProvider),
      ref: ref,
    );
  }
  final PostService postService;
  final Ref ref;

  void resetState() => state = PostState.initial();

  Future<void> getPostsList() async {
    state = state.copyWith(isLoading: true);
    final res = await postService.getPostList();
    state = state.copyWith(isLoading: false);
    res.fold(
      (left) => state = state.copyWith(
        isError: left,
        isInitState: false,
      ),
      (right) => state = state.copyWith(
        posts: right,
        isInitState: false,
      ),
    );
  }
}
