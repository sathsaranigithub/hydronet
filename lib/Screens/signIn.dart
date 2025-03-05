import 'package:flutter/material.dart';
import 'package:lettus/Screens/getStart.dart';
import 'package:lettus/Screens/signUp.dart';
import 'package:lettus/Services/authService.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Utils/constValues.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Utils/validations.dart';
import 'package:lettus/Widgets/button.dart';
import 'package:lettus/Widgets/label.dart';
import 'package:lettus/Widgets/labelResponsive.dart';
import 'package:lettus/Widgets/loading.dart';
import 'package:lettus/Widgets/myTextField.dart';
import 'package:lettus/Widgets/snackBar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool clicked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        NavigationUtils.backNavigation(context, GetStart());
      },
      child: Stack(children: [
        Scaffold(
            backgroundColor: AppColors.white1,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 42.0, right: 42.0, top: 33.0, bottom: 33.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label(
                                hintText: "Welcome back",
                                textColor: AppColors.black1,
                                fontSize: AppFonts.font24,
                                fontFamily: AppFonts.lexend,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height * 34) /
                                      913,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width * 326) /
                                        430,
                                child: LabelResponsive(
                                    hintText:
                                        "Welcome to our Lettuce Yield Prediction platform,",
                                    textColor: AppColors.black2,
                                    fontSize: AppFonts.font16,
                                    fontFamily: AppFonts.songMyung,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height * 23) /
                                      913,
                            ),
                            MyTextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              hintText: "E-mail",
                              borderColor: AppColors.gray1,
                              col1: AppColors.white1,
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height * 23) /
                                      913,
                            ),
                            MyTextField(
                              obscureText: true,
                              controller: passwordController,
                              hintText: "Password",
                              borderColor: AppColors.gray1,
                              col1: AppColors.white1,
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height * 53) /
                                      913,
                            ),
                            Button(
                              onPressed: () async {
                                await buttonLogic(context);
                              },
                              text: "Login",
                              buttonColor: AppColors.green1,
                              width: double.infinity,
                              fontSize: AppFonts.font20,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height * 39) /
                                      913,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: (MediaQuery.of(context).size.height *
                                          261) /
                                      913,
                                  width: (MediaQuery.of(context).size.width *
                                          208) /
                                      430,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/symbol.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Label(
                            hintText: "Don’t have an account ? ",
                            textColor: AppColors.black1,
                            fontSize: AppFonts.font18,
                            fontFamily: AppFonts.roboto,
                            fontWeight: FontWeight.bold),
                        GestureDetector(
                          onTap: () {
                            NavigationUtils.frontNavigation(context, SignUp());
                          },
                          child: Label(
                              hintText: "Register",
                              textColor: AppColors.black1,
                              fontSize: AppFonts.font18,
                              fontFamily: AppFonts.roboto,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        if (clicked) const Loading(),
      ]),
    );
  }

  Future<void> buttonLogic(BuildContext context) async {
    if (clicked == false) {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        bool isValid = Validations.emailValidation(emailController.text);
        if (isValid == true) {
          setState(() {
            clicked = true;
          });
          AuthService authService = AuthService();
          await authService
              .signIn(context, emailController.text, passwordController.text)
              .then((value) {
            setState(() {
              clicked = false;
            });
          });
        } else {
          SnackbarUtils.showDefaultSnackBar(
              context, ConstValues.validEmailMsg, AppColors.errorcolor);
        }
      } else {
        SnackbarUtils.showDefaultSnackBar(
            context, ConstValues.allRequiredMsg, AppColors.errorcolor);
      }
    }
  }
}
