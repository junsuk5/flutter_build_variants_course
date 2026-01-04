import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_memo_app/core/config/flavor_config.dart';
import 'package:flavor_memo_app/data/repository/firebase_auth_repository_impl.dart';
import 'package:flavor_memo_app/data/repository/firestore_post_repository_impl.dart';
import 'package:flavor_memo_app/data/repository/mock_auth_repository_impl.dart';
import 'package:flavor_memo_app/data/repository/mock_post_repository_impl.dart';
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
      final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
      FirebaseAuth.instance.useAuthEmulator(host, 9099);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);

      getIt.registerLazySingleton<AuthRepository>(
        () => FirebaseAuthRepositoryImpl(FirebaseAuth.instance),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => FirestorePostRepositoryImpl(FirebaseFirestore.instance),
      );
      break;
    case Flavor.prod:
      getIt.registerLazySingleton<AuthRepository>(
        () => FirebaseAuthRepositoryImpl(FirebaseAuth.instance),
      );
      getIt.registerLazySingleton<PostRepository>(
        () => FirestorePostRepositoryImpl(FirebaseFirestore.instance),
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
