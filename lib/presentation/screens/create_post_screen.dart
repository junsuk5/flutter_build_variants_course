import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/post.dart';
import '../../data/models/user.dart';
import '../../data/repositories/post_repository.dart';

class CreatePostScreen extends StatefulWidget {
  final PostRepository postRepository;

  const CreatePostScreen({super.key, required this.postRepository});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _contentController = TextEditingController();
  XFile? _pickedImage;
  final _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _pickedImage = image);
    }
  }

  void _uploadPost() async {
    if (_contentController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('내용을 입력해주세요.')));
      return;
    }

    setState(() => _isUploading = true);

    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _contentController.text,
      // 실제 앱에서는 이미지를 서버에 올리고 URL을 받아오겠지만,
      // 여기서는 데모를 위해 로컬 경로 또는 랜덤 이미지를 사용합니다.
      imageUrl: _pickedImage?.path != null
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

    await widget.postRepository.addPost(newPost);

    if (mounted) {
      setState(() => _isUploading = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          TextButton(
            onPressed: _isUploading ? null : _uploadPost,
            child: _isUploading
                ? const CircularProgressIndicator(strokeWidth: 2)
                : const Text(
                    '공유',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _pickedImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              '사진을 선택하세요',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_pickedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: '문구 입력...',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
