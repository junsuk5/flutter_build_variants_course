import 'package:flavor_memo_app/domain/repository/post_repository.dart';

import '../../domain/model/post.dart';
import '../../domain/model/user.dart';

class MockPostRepositoryImpl implements PostRepository {
  final List<Post> _posts = [
    Post(
      id: '1',
      content: '플러터로 만드는 인스타그램 클론! 재미있네요.',
      imageUrl: 'https://picsum.photos/id/1/600/600',
      user: const User(
        id: '2',
        email: 'dev@flutter.com',
        name: 'Flutter Dev',
        profileImageUrl: 'https://picsum.photos/id/10/200/200',
      ),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: '2',
      content: '오늘 점심은 맛있는 파스타를 먹었습니다. #맛스타그램',
      imageUrl: 'https://picsum.photos/id/102/600/600',
      user: const User(
        id: '3',
        email: 'foodie@insta.com',
        name: 'Foodie',
        profileImageUrl: 'https://picsum.photos/id/20/200/200',
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_posts.reversed);
  }

  @override
  Future<void> addPost(Post post) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _posts.add(post);
  }
}
