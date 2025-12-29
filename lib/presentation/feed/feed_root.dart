import 'package:flavor_memo_app/presentation/feed/feed_action.dart';
import 'package:flavor_memo_app/presentation/feed/feed_screen.dart';
import 'package:flavor_memo_app/presentation/feed/feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeedRoot extends StatelessWidget {
  final FeedViewModel viewModel;

  const FeedRoot({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return FeedScreen(
          state: viewModel.state,
          onAction: (action) {
            switch(action) {
              case LoadPosts():
                viewModel.onAction(action);
                break;
              case CreatePost():
                context.push('/create-post');
                break;
            }
          },
        );
      },
    );
  }
}
