import 'package:flavor_memo_app/domain/repository/auth_repository.dart';

import '../../domain/model/user.dart';



class MockAuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> login(String email, String password) async {
    // 로그인 시뮬레이션 (1초 대기)
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test@test.com' && password == '1234') {
      return const User(
        id: '1',
        email: 'test@test.com',
        name: '생존코딩 오준석',
        profileImageUrl: 'https://picsum.photos/id/64/200/200',
      );
    }
    return null;
  }
}
