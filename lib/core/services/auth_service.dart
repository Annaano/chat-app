import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/core/const/user_data_const.dart';
import 'package:chat_app/core/exceptions.dart';

import 'package:chat_app/core/services/user_storage.dart';
import 'package:chat_app/data/user_data.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User> registration(
      String email, String password, String name) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    final User user = result.user!;
    await user.updateDisplayName(name);

    final userData = UserData.fromFirebase(auth.currentUser);
    await UserStorage.createData(email, userData.toString());
    UserDataConst.currentUser = userData;

    return user;
  }

  static Future resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future deactivateAccount() async {
    final User user = auth.currentUser!;
    try {
      await user.delete();
      return true;
    } catch (e) {}
  }

  static Future<User?> login(String email, String password) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? user = result.user;

      if (user == null) {
        throw Exception("User not found");
      } else {
        final userFromLocal = await UserStorage.getData(email);
        final userData = UserData.fromFirebase(auth.currentUser);
        if (userFromLocal == null) {
          await UserStorage.createData(email, userData.toString());
        }
        UserDataConst.currentUser = userData;
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException(getExceptionMessage(e));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> logOut() async {
    await auth.signOut();
  }
}

String getExceptionMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return 'User not found';
    case 'wrong-password':
      return 'Password is incorrect';
    case 'requires-recent-login':
      return 'Log in again before retrying this request';
    default:
      return e.message ?? 'Error';
  }
}
