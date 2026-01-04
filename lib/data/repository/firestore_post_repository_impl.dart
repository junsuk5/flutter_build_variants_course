import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_memo_app/domain/model/post.dart';
import 'package:flavor_memo_app/domain/repository/post_repository.dart';

class FirestorePostRepositoryImpl implements PostRepository {
  final FirebaseFirestore _firestore;

  FirestorePostRepositoryImpl(this._firestore);

  @override
  Future<List<Post>> getPosts() async {
    final querySnapshot = await _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();
    return querySnapshot.docs
        .map((doc) => Post.fromJson(doc.data()..['id'] = doc.id))
        .toList();
  }

  @override
  Future<void> addPost(Post post) async {
    await _firestore.collection('posts').doc(post.id).set(post.toJson());
  }
}
