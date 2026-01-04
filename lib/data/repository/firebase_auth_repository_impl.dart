import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flavor_memo_app/domain/model/user.dart';
import 'package:flavor_memo_app/domain/repository/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepositoryImpl(this._auth);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return User(
        id: result.user!.uid,
        email: result.user!.email!,
        name: result.user!.displayName ?? '',
        profileImageUrl: result.user!.photoURL ?? '',
      );
    } on FirebaseAuthException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
