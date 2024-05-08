import 'package:firebase_auth/firebase_auth.dart';
import 'package:frivillighed_rfam/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class AuthenticationHelper {
  static final AuthenticationHelper _singleton =
      AuthenticationHelper._internal();

  final _auth = FirebaseAuth.instance;

  factory AuthenticationHelper() {
    return _singleton;
  }

  AuthenticationHelper._internal();

  User? get currentUser => _auth.currentUser;

  Future<void> signIn(String username, String password) async {
    final email = "${username}@maxkandersen.dk";

    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
