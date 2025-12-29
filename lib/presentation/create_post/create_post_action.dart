import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_action.freezed.dart';

@freezed
sealed class CreatePostAction with _$CreatePostAction {
  const factory CreatePostAction.onPickImage() = OnPickImage;
  const factory CreatePostAction.onUpload(String content) = OnUpload;
}
