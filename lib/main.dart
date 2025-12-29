import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/post_repository.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/feed_screen.dart';
import 'presentation/screens/create_post_screen.dart';

void main() {
  // 앱 전역에서 사용할 저장소 인스턴스 (단순화를 위해 싱글톤처럼 사용하거나
  // 실제 앱에서는 Provider 등을 사용하겠지만 여기서는 수동 주입)
  final authRepository = MockAuthRepository();
  final postRepository = MockPostRepository();

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            LoginScreen(authRepository: authRepository),
      ),
      GoRoute(
        path: '/feed',
        builder: (context, state) => FeedScreen(postRepository: postRepository),
      ),
      GoRoute(
        path: '/create-post',
        builder: (context, state) =>
            CreatePostScreen(postRepository: postRepository),
      ),
    ],
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flavor Memo SNS',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
    );
  }
}
