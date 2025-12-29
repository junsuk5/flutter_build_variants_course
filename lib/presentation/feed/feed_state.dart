import 'package:flavor_memo_app/domain/model/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_state.freezed.dart';

@freezed
class FeedState with _$FeedState {
  @override
  final List<Post> posts;

  @override
  final bool isLoading;

  const FeedState({
    this.posts = const [],
    this.isLoading = false,
  });
}