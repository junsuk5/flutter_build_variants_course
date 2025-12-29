import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_event.freezed.dart';

@freezed
class CreatePostEvent with _$CreatePostEvent {
  const factory CreatePostEvent.successUploadPost() = SuccessUploadPost;
}