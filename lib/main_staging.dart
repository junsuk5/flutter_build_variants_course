import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/my_app.dart';
import 'package:flavor_memo_app/presentation/feed/feed_root.dart';
import 'package:flavor_memo_app/presentation/feed/feed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/repository/auth_repository_impl.dart';
import 'data/repository/post_repository_impl.dart';
import 'presentation/create_post/create_post_screen.dart';
import 'presentation/login/login_screen.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.staging;

  // 앱 전역에서 사용할 저장소 인스턴스 (단순화를 위해 싱글톤처럼 사용하거나
  // 실제 앱에서는 Provider 등을 사용하겠지만 여기서는 수동 주입)
  final authRepository = MockAuthRepositoryImpl();
  final postRepository = MockPostRepositoryImpl();

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
        builder: (context, state) =>
            FeedRoot(viewModel: FeedViewModel(postRepository: postRepository)),
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
