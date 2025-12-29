import 'package:flavor_memo_app/presentation/create_post/create_post_action.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_event.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_screen.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_view_model.dart';
import 'package:flutter/material.dart';

class CreatePostRoot extends StatefulWidget {
  final CreatePostViewModel viewModel;

  const CreatePostRoot({super.key, required this.viewModel});

  @override
  State<CreatePostRoot> createState() => _CreatePostRootState();
}

class _CreatePostRootState extends State<CreatePostRoot> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.event.listen((event) {
      if (event is SuccessUploadPost) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return CreatePostScreen(
          state: widget.viewModel.state,
          onAction: (action) async {
            switch (action) {
              case OnPickImage():
                widget.viewModel.onAction(action);
              case OnUpload():
                widget.viewModel.onAction(action);
            }
          },
        );
      },
    );
  }
}
