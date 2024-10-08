import 'package:equatable/equatable.dart';
import 'package:prueba_fudo/data/models/post_model.dart';

final class PostState extends Equatable {
  const PostState({
    this.posts,
    this.isLoading = false,
    this.isInitState = true,
    this.isError,
  });

  final List<Post>? posts;
  final bool isLoading;
  final String? isError;
  final bool isInitState;

  factory PostState.initial() => const PostState();

  PostState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? isError,
    bool? isInitState,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isInitState: isInitState ?? this.isInitState,
    );
  }

  @override
  List<Object?> get props => [
        posts,
        isError,
        isInitState,
        isLoading,
      ];
}
