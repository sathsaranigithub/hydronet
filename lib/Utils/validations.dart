import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lettus/Screens/signIn.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/popUpMsgBox.dart';
import 'package:lettus/Widgets/snackBar.dart';

class Validations {
  static bool emailValidation(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    bool valid = regExp.hasMatch(email);
    return valid;
  }

  static void showWinningDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Popupmsgbox(
              show: false,
              t1: 'Logout',
              t2: 'Are you sure you want to logout?',
              t3: 'Yes',
              onTap: () {
                Navigator.pop(context);
              },
              onTap1: () async {
                Navigator.pop(context);

                try {
                  await FirebaseAuth.instance.signOut();

                  print("object");
                  NavigationUtils.backNavigation(context, SignIn());
                } catch (e) {
                  SnackbarUtils.showDefaultSnackBar(
                      context,
                      "Something went wrong & please recheck",
                      AppColors.errorcolor);

                  print("Sign out error: $e");
                }
              }),
        );
      },
    );
  }
}
