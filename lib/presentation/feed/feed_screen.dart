import 'package:flavor_memo_app/presentation/feed/feed_action.dart';
import 'package:flavor_memo_app/presentation/feed/feed_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/post_card.dart';

class FeedScreen extends StatelessWidget {
  final FeedState state;
  final Function(FeedAction) onAction;

  const FeedScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flavor Memo SNS',
          style: GoogleFonts.lobster(fontSize: 24, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () => onAction(FeedAction.loadPosts()),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => onAction(FeedAction.loadPosts()),
              child: ListView.separated(
                itemCount: state.posts.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return PostCard(post: state.posts[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAction(FeedAction.createPost()),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ),
    );
  }
}
