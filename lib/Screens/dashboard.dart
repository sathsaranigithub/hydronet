import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                        NavigationUtils.frontNavigation(context, PedictionPage());
                      },
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
