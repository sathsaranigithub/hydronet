import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Widgets/label.dart';
import 'package:provider/provider.dart';

import 'package:lettus/Providers/provider.dart';
import 'package:lettus/Screens/pedictionPage.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Utils/validations.dart';
import 'package:lettus/Widgets/dashboardCard.dart';
import 'package:lettus/Widgets/dashboardTopCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late User userem;
  @override
  Widget build(BuildContext context) {
    userem = FirebaseAuth.instance.currentUser!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Validations.showWinningDialog(context);
      },
      child: Scaffold(
        body: Column(
          children: [
            DashboardTopCard(
              onTap: () {
                Validations.showWinningDialog(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DashboardCard(
                      labelText: "Lettuce Yield Prediction",
                      imagePath: 'assets/c1img.png',
                      onTap: () {
                        final formProvider =
                            Provider.of<MyModel>(context, listen: false);

                        formProvider.updateEmail(userem.email);
                        NavigationUtils.frontNavigation(
                            context, PedictionPage());
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Label(
                                  hintText: "Lettuce Colour:Low green",
                                  textColor: AppColors.green1,
                                  fontSize: AppFonts.font14,
                                  fontFamily: AppFonts.lemonada,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white1,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.green1,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 4),
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        width: (MediaQuery.of(context).size.width - 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Label(
                                  hintText: "Lettuce weight:23kg",
                                  textColor: AppColors.green1,
                                  fontSize: AppFonts.font14,
                                  fontFamily: AppFonts.lemonada,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white1,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.green1,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 4),
                              blurRadius: 6.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        width: (MediaQuery.of(context).size.width - 16),
                      ),
                    ),
                    DashboardCard(
                      labelText: "SECOND component",
                      imagePath: 'assets/c2img.png',
                      onTap: () {},
                    ),
                    DashboardCard(
                      labelText: "SECOND component",
                      imagePath: 'assets/c2img.png',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
