import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_action.freezed.dart';

@freezed
sealed class FeedAction with _$FeedAction {
  const factory FeedAction.loadPosts() = LoadPosts;
  const factory FeedAction.createPost() = CreatePost;
}
