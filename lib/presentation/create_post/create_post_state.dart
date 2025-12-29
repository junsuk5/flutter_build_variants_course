import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_state.freezed.dart';

@freezed
abstract class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    String? imagePath,
    @Default(false) bool isUploading,
  }) = _CreatePostState;
}
