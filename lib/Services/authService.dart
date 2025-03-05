import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lettus/Screens/dashboard.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/snackBar.dart';

class AuthService {
  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      NavigationUtils.frontNavigation(context, Dashboard());
    } catch (e) {
      if (e is FirebaseAuthException) {
        String errorMessage = 'An error occurred';
        if (e.code == 'firebase_auth/channel-error') {
          errorMessage = 'Unable to establish connection on channel.';
        } else {
          errorMessage = e.message ?? errorMessage;
        }
        SnackbarUtils.showDefaultSnackBar(
            context, errorMessage, AppColors.errorcolor);
      }
    }
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      NavigationUtils.frontNavigation(context, Dashboard());
    } catch (e) {
      if (e is FirebaseAuthException) {
        print('FirebaseAuthException: ${e.message}');
        SnackbarUtils.showDefaultSnackBar(
            context, "${e.message}", AppColors.errorcolor);
      } else {
        print('Error: $e');
        SnackbarUtils.showDefaultSnackBar(context,
            "Something went wrong & please recheck", AppColors.errorcolor);
      }
    }
  }
}
