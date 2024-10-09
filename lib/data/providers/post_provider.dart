import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/data/models/post_model.dart';
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

  Future<void> getPostsList({int? userId}) async {
    state = state.copyWith(isLoading: true);
    final res = await postService.getPostList(userId: userId);
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

  Future<void> createPost(
    Post post,
    BuildContext context,
  ) async {
    state = state.copyWith(isLoading: true);
    final res = await postService.createPost(post: post);
    state = state.copyWith(isLoading: false);
    await Future.delayed(const Duration(microseconds: 1));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
