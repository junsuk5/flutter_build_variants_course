import 'user.dart';

class Post {
  final String id;
  final String content;
  final String? imageUrl;
  final User user;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.content,
    this.imageUrl,
    required this.user,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'user': user.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Post(id: $id, content: $content, imageUrl: $imageUrl, user: ${user.name}, createdAt: $createdAt)';
  }
}
