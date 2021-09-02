import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/ui/screens/auth_main_screen.dart';
import 'package:gsg_firebase/chat/ui/screens/home_screen.dart';
import 'package:gsg_firebase/services/route_helper.dart';
import 'package:gsg_firebase/widgets/global_widgets.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserCredential userCredential;

  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }

  signup(String email, String password) async {
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final id = userCredential.user.uid;
      final token = await userCredential.user.getIdToken();
      print('User Id: $id'); // ? unique number
      print(
          'User Token: $token'); // ? unique key for secure and safe communication between client and server
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        GlobalWidgets.globalWidgets.showCustomDialog(
          context: RouteHelper.routeHelper.navigatorKey.currentContext,
          text: 'The password provided is too weak.',
          title: 'Error!!',
          titleColor: Colors.red,
          action1Title: 'Ok',
          action1Function: () {
            RouteHelper.routeHelper.pop();
          },
        );
      } else if (e.code == 'email-already-in-use') {
        GlobalWidgets.globalWidgets.showCustomDialog(
          context: RouteHelper.routeHelper.navigatorKey.currentContext,
          text: 'The account already exists for that email.',
          title: 'Error!!',
          titleColor: Colors.red,
          action1Title: 'Ok',
          action1Function: () {
            RouteHelper.routeHelper.pop();
          },
        );
      }
    } catch (e) {
      GlobalWidgets.globalWidgets.showCustomDialog(
        context: RouteHelper.routeHelper.navigatorKey.currentContext,
        text: '${e.toString()}',
        title: 'Error!!',
        titleColor: Colors.red,
        action1Title: 'Ok',
        action1Function: () {
          RouteHelper.routeHelper.pop();
        },
      );
    }
  }

  Future<UserCredential> signin(String email, String password) async {
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      verifyUser();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        GlobalWidgets.globalWidgets.showCustomDialog(
          context: RouteHelper.routeHelper.navigatorKey.currentContext,
          text: 'No user found for that email.',
          title: 'Error!!',
          titleColor: Colors.red,
          action1Title: 'Ok',
          action1Function: () {
            RouteHelper.routeHelper.pop();
          },
        );
      } else if (e.code == 'wrong-password') {
        GlobalWidgets.globalWidgets.showCustomDialog(
          context: RouteHelper.routeHelper.navigatorKey.currentContext,
          text: 'Wrong password provided for that user.',
          title: 'Error!!',
          titleColor: Colors.red,
          action1Title: 'Ok',
          action1Function: () {
            RouteHelper.routeHelper.pop();
          },
        );
      }
      // else {
      //   await verifyUser();
      // }
    }
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    GlobalWidgets.globalWidgets.showCustomDialog(
      context: RouteHelper.routeHelper.navigatorKey.currentContext,
      text: 'We have sent you an email to reset your password.',
      action1Title: 'Ok',
      action1Function: () {
        RouteHelper.routeHelper.pop();
      },
    );
  }

  verifyUser() async {
    bool isEmailVerified = checkEmailVerification();
    if (isEmailVerified) {
      RouteHelper.routeHelper.pushReplacementNamed(HomeScreen.routeName);
    } else {
      GlobalWidgets.globalWidgets.showCustomDialog(
        context: RouteHelper.routeHelper.navigatorKey.currentContext,
        text:
            'You have to verify your email, click ok to send you another email verification.',
        title: 'Caution!',
        titleColor: Colors.red,
        action1Title: 'Ok',
        action1Function: sendVerificationEmail,
        action2Title: 'Cancel',
        action2Function: () {
          RouteHelper.routeHelper.pop();
        },
      );
    }
  }

  verifyEmail() async {
    final user = firebaseAuth.currentUser;
    await user.sendEmailVerification();
    GlobalWidgets.globalWidgets.showCustomDialog(
      context: RouteHelper.routeHelper.navigatorKey.currentContext,
      text: 'A verification email has been sent to ${user.email}.',
      action1Title: 'Ok',
      action1Function: () {
        RouteHelper.routeHelper.pop();
      },
    );
  }

  logoutOnly() async {
    await firebaseAuth.signOut();
  }

  logout() async {
    GlobalWidgets.globalWidgets.showCustomDialog(
      context: RouteHelper.routeHelper.navigatorKey.currentContext,
      text: 'Are you sure you want to logout?',
      title: 'Logout!',
      titleColor: Colors.red,
      action1Title: 'Yes',
      action1Function: () {
        firebaseAuth.signOut();
        RouteHelper.routeHelper.pushReplacementNamed(AuthMainScreen.routeName);
      },
      action2Title: 'No',
      action2Function: () {
        RouteHelper.routeHelper.pop();
      },
    );
  }

  sendVerificationEmail() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logoutOnly();
    RouteHelper.routeHelper.pop();
  }

  bool checkEmailVerification() {
    final user = firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  bool checkUserLogin() {
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
