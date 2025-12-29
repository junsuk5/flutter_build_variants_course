import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/data/repository/auth_repository_impl.dart';
import 'package:flavor_memo_app/data/repository/post_repository_impl.dart';
import 'package:flavor_memo_app/domain/repository/auth_repository.dart';
import 'package:flavor_memo_app/domain/repository/post_repository.dart';
import 'package:flavor_memo_app/presentation/create_post/create_post_view_model.dart';
import 'package:flavor_memo_app/presentation/feed/feed_view_model.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupDI() {
  _setupRepositories();
  _setupViewModels();
}

void _setupRepositories() {
  switch (FlavorConfig.appFlavor) {
    case Flavor.dev:
      getIt.registerLazySingleton<AuthRepository>(
        () => MockAuthRepositoryImpl(),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => MockPostRepositoryImpl(),
      );
      break;
    case Flavor.staging:
      getIt.registerLazySingleton<AuthRepository>(
        () => MockAuthRepositoryImpl(),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => MockPostRepositoryImpl(),
      );
      break;
    case Flavor.prod:
      getIt.registerLazySingleton<AuthRepository>(
        () => MockAuthRepositoryImpl(),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => MockPostRepositoryImpl(),
      );
      break;
    default:
      getIt.registerLazySingleton<AuthRepository>(
        () => MockAuthRepositoryImpl(),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => MockPostRepositoryImpl(),
      );
  }
}

void _setupViewModels() {
  getIt.registerFactory(
    () => FeedViewModel(postRepository: getIt<PostRepository>()),
  );
  getIt.registerFactory(
    () => CreatePostViewModel(postRepository: getIt<PostRepository>()),
  );
}
