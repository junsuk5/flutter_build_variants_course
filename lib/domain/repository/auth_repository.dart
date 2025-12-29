import 'package:flavor_memo_app/domain/model/user.dart';

abstract interface class AuthRepository {
  Future<User?> login(String email, String password);
}
