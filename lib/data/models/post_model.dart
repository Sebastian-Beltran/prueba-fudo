import 'package:equatable/equatable.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  final int id;
  final String title;
  final String body;
  final int userId;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        userId,
      ];
}
