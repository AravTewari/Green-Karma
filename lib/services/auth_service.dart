import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_karma/common/globals.dart';
import 'package:green_karma/models/green_karma_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<GreenKarmaUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  GreenKarmaUser _userFromFirebaseUser(User user) {
    if (user == null) {
      return null;
    }
    return GreenKarmaUser.fromFirebaseUser(user);
  }

  Future registerWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user;

      GreenKarmaUser gkUser = _userFromFirebaseUser(user);
      globalDisplayName = displayName;
      return gkUser;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = result.user;
      return GreenKarmaUser.fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
