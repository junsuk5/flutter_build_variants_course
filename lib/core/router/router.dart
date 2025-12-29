import 'package:flavor_memo_app/core/di/di_setup.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_root.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_view_model.dart';
import 'package:flavor_memo_app/presentation/feed/feed_root.dart';
import 'package:flavor_memo_app/presentation/feed/feed_view_model.dart';
import 'package:flavor_memo_app/presentation/login/login_screen.dart';
import 'package:flavor_memo_app/domain/repository/auth_repository.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          LoginScreen(authRepository: getIt<AuthRepository>()),
    ),
    GoRoute(
      path: '/feed',
      builder: (context, state) {
        final viewModel = getIt<FeedViewModel>();
        viewModel.getPosts();
        return FeedRoot(viewModel: viewModel);
      },
    ),
    GoRoute(
      path: '/create-post',
      builder: (context, state) =>
          CreatePostRoot(viewModel: getIt<CreatePostViewModel>()),
    ),
  ],
);
