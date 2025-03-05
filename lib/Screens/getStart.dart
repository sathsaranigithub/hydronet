import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/button.dart';
import 'package:lettus/Widgets/label.dart';
import 'package:lettus/Widgets/labelResponsive.dart';
import 'package:lettus/Screens/signIn.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(34.0),
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(
                    isItalic: true,
                    hintText: "HydroNet",
                    textColor: AppColors.white2,
                    fontSize: AppFonts.font36,
                    fontFamily: "lemonada",
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 20) / 901,
                ),
                LabelResponsive(
                    isItalic: true,
                    hintText:
                        "Empowering  farmers with cutting-edge AI technology",
                    textColor: AppColors.white1,
                    fontSize: AppFonts.font22,
                    fontFamily: "lemonada",
                    fontWeight: FontWeight.normal),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 35) / 901,
                ),
                Button(
                    onPressed: () {
                      NavigationUtils.frontNavigation(context, SignIn());
                    },
                    text: "Get start",
                    buttonColor: AppColors.green1,
                    width: (MediaQuery.of(context).size.width * 194) / 430,
                    fontSize: AppFonts.font20,
                    fontWeight: FontWeight.w500)
              ],
            )),
          ),
        ),
      ),
    );
  }
}
