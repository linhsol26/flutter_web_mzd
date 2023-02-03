import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_mzd/core/domain/failure.dart';
import 'package:web_mzd/core/domain/user.dart';
import 'package:web_mzd/home/infrastructure/collection_path.dart';

class AuthRepository {
  final GoogleAuthProvider _googleAuth;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._googleAuth, this._auth, this._firestore);

  Future<Either<Failure, Unit>> signInWithGoogle() async {
    try {
      final credential = await _auth.signInWithPopup(_googleAuth);

      await _addUserInfo(credential.user);

      return right(unit);
    } catch (e) {
      return left(const Failure());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  _addUserInfo(User? user) async {
    if (user != null) {
      await _firestore.collection(CollectionPath.users).doc(user.uid).set({'uid': user.uid});
    }
  }

  updateUserInfo(UserModel user) async {
    await _firestore.collection(CollectionPath.users).doc(user.uid).update(user.toJson());
  }
}
