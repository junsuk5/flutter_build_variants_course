import 'dart:async';

import 'package:flavor_memo_app/domain/model/post.dart';
import 'package:flavor_memo_app/domain/model/user.dart';
import 'package:flavor_memo_app/domain/repository/post_repository.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_action.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_event.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_state.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostViewModel extends ChangeNotifier {
  final PostRepository postRepository;
  final _picker = ImagePicker();

  CreatePostState _state = const CreatePostState();
  CreatePostState get state => _state;

  final _eventController = StreamController<CreatePostEvent>();
  Stream<CreatePostEvent> get event => _eventController.stream;

  CreatePostViewModel({required this.postRepository});

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _state = _state.copyWith(imagePath: image.path);
      notifyListeners();
    }
  }

  Future<bool> _uploadPost(String content) async {
    if (content.isEmpty) return false;

    _state = _state.copyWith(isUploading: true);
    notifyListeners();

    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      imageUrl: _state.imagePath != null
          ? 'https://picsum.photos/id/${DateTime.now().second}/600/600'
          : null,
      user: const User(
        id: '1',
        email: 'test@test.com',
        name: '생존코딩 오준석',
        profileImageUrl: 'https://picsum.photos/id/64/200/200',
      ),
      createdAt: DateTime.now(),
    );

    await postRepository.addPost(newPost);

    _state = _state.copyWith(isUploading: false);
    notifyListeners();
    return true;
  }

  void onAction(CreatePostAction action) async {
    switch (action) {
      case OnPickImage():
        _pickImage();
      case OnUpload():
        final result = await _uploadPost(action.content);
        if (result) {
          _eventController.add(CreatePostEvent.successUploadPost());
        }
    }
  }
}
