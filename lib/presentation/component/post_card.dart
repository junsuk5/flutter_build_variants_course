import 'package:flutter/material.dart';
import '../../domain/model/post.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Info
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(post.user.profileImageUrl),
                radius: 18,
              ),
              const SizedBox(width: 10),
              Text(
                post.user.name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),
        ),
        // Image
        if (post.imageUrl != null)
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              post.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
          )
        else
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[200],
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.favorite_border, size: 28),
              const SizedBox(width: 16),
              const Icon(Icons.chat_bubble_outline, size: 28),
              const SizedBox(width: 16),
              const Icon(Icons.send_outlined, size: 28),
              const Spacer(),
              const Icon(Icons.bookmark_border, size: 28),
            ],
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: '${post.user.name} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: post.content),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${post.createdAt.year}년 ${post.createdAt.month}월 ${post.createdAt.day}일',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
