import 'dart:io';
import 'package:flavor_memo_app/presentation/create_post/create_post_action.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_state.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final CreatePostState state;
  final Function(CreatePostAction) onAction;

  const CreatePostScreen({
    super.key,
    required this.state,
    required this.onAction,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          TextButton(
            onPressed: widget.state.isUploading
                ? null
                : () => widget.onAction(
                    CreatePostAction.onUpload(_contentController.text),
                  ),
            child: widget.state.isUploading
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
                onTap: () =>
                    widget.onAction(const CreatePostAction.onPickImage()),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: widget.state.imagePath == null
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
                            File(widget.state.imagePath!),
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
