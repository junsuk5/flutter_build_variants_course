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

  @override
  String toString() {
    return 'Post(id: $id, content: $content, imageUrl: $imageUrl, user: ${user.name}, createdAt: $createdAt)';
  }
}
