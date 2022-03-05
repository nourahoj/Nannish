import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nannyish/users.dart';
import 'package:nannyish/preferences/app_preferences.dart';

import '../main.dart';
import 'fb_firestore.dart';

class FbAuthController {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> createAccount(BuildContext context,
      {required Users users, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: users.email, password: password);

      await FbFireStoreController().createUser(
          context: context, users: users, uid: userCredential.user!.uid);
      if (users.type == 'Parent') {
        await FbFireStoreController()
            .createArray(nameDoc: userCredential.user!.uid);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      _controlErrorCodes(context, e);
    } catch (e) {
      showMaterialDialog_login(context, 'There is a problem with the internet');
      print('Exception: $e');
    }
    return false;
  }

  Future<bool> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      loadingDialog(context, true);

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      Users dataUserLogin = await FbFireStoreController()
          .getUserData(uid: userCredential.user!.uid);
      await AppPreferences()
          .saveLogin(users: dataUserLogin, uid: userCredential.user!.uid);

      String type = dataUserLogin.type;
      goToScreen(context, type);
      return true;
    } on FirebaseAuthException catch (e) {
      _controlErrorCodes(context, e);
    } catch (e) {
      showMaterialDialog_login(
          context, 'Make sure you are connected to the internet');
      print('Exception: $e');
    }
    return false;
  }

  Future<void> signOut(BuildContext context) async {
    await AppPreferences().logout();
    await _firebaseAuth.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
        'login_screen', (Route<dynamic> route) => false);
  }

  void _controlErrorCodes(
      BuildContext context, FirebaseAuthException authException) {
    // showMaterialDialog_login(
    //     context: context, content: authException.message ?? '', error: true);
    print(authException.code);
    switch (authException.code) {
      case 'email-already-in-use':
        loadingDialog(context, false);
        showMaterialDialog_login(context, 'This email already exists');
        break;

      case 'user-name-already-in-use':
        loadingDialog(context, false);
        showMaterialDialog_login(context, 'This user name already exists');
        break;

      case 'invalid-email':
        loadingDialog(context, false);

        showMaterialDialog_login(
          context,
          'Enter a valid email',
        );
        break;

      case 'operation-not-allowed':
        loadingDialog(context, false);

        break;

      case 'weak-password':
        loadingDialog(context, false);

        showMaterialDialog_login(
          context,
          'The password used is weak',
        );

        break;

      case 'user-not-found':
        loadingDialog(context, false);

        showMaterialDialog_login(
          context,
          'Incorrect email or password',
        );

        break;

      case 'requires-recent-login':
        loadingDialog(context, false);

        break;

      case 'wrong-password':
        loadingDialog(context, false);

        showMaterialDialog_login(
          context,
          'Incorrect email or password',
        );
        break;

      case 'too-many-requests':
        loadingDialog(context, false);

        showMaterialDialog_login(context, 'sent a lot of requests');
        break;
    }
  }

  void goToScreen(BuildContext context, String type) {
    loadingDialog(context, false);
    if (type == 'Nanny') {
      Navigator.of(context).pushNamedAndRemoveUntil(
        'Nav_n',
        (Route<dynamic> route) => false,
        arguments: {'uid': AppPreferences().getUserData.uid},
      );
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        'Nav_p',
        (Route<dynamic> route) => false,
        arguments: {'uid': AppPreferences().getUserData.uid},
      );
    }
  }

  void loadingDialog(BuildContext context, bool run) {
    if (run)
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    else {
      Navigator.pop(context);
    }
  }
}
