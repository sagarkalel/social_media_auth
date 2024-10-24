import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  /// create account
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// login through email and password
  Future<bool> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  /// logout user
  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final usr = FirebaseAuth.instance.currentUser;
      return usr != null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
