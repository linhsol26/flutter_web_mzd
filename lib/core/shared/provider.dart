import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_mzd/auth/infrastructure/auth_repo.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    GoogleAuthProvider(),
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );
});
