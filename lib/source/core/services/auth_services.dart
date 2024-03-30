import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthServices {
  Future<User?> signInAnonymously();
}

@Singleton(as: AuthServices)
class Auth implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> signInAnonymously() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.delete();
    }
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }
}
