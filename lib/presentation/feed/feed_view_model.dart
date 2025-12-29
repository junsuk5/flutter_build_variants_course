import 'package:flavor_memo_app/domain/repository/post_repository.dart';
import 'package:flavor_memo_app/presentation/feed/feed_action.dart';
import 'package:flavor_memo_app/presentation/feed/feed_state.dart';
import 'package:flutter/material.dart';

class FeedViewModel extends ChangeNotifier {
  final PostRepository postRepository;

  FeedState _state = const FeedState();
  FeedState get state => _state;

  FeedViewModel({required this.postRepository});

  Future<void> getPosts() async {
    try {
      final posts = await postRepository.getPosts();
      _state = _state.copyWith(posts: posts, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
    }
    notifyListeners();
  }

  void onAction(FeedAction action) {
    action.when(
      loadPosts: () => getPosts(),
      createPost: () {
        // 내비게이션은 UI 레이어에서 처리하는 것이 좋으므로
        // 필요한 경우 이벤트를 통해 알리거나 FeedRoot에서 직접 처리합니다.
      },
    );
  }
}
