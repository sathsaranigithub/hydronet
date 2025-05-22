import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lettus/Services/predictService.dart';
import 'package:lettus/Widgets/loading.dart';
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
  bool clicked = false;
  String lCOlor = "";
  String lWeight = "";

  @override
  void initState() {
    super.initState();
    initProcess();
  }

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
      child: Stack(children: [
        Scaffold(
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
                      DashboardCard(
                        labelText: "Lettuce Quality",
                        imagePath: 'assets/abc.png',
                        onTap: () {},
                        lCOlor: lCOlor,
                        lWeight: lWeight,
                        isShow: true,
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
        if (clicked) const Loading(),
      ]),
    );
  }

  Future<void> initProcess() async {
    if (!clicked) {
      setState(() {
        clicked = true;
      });

      final formProvider = Provider.of<MyModel>(context, listen: false);

      PredictService predictService = PredictService();
      predictService.fetchIotData(context).then((value) {
        setState(() {
          lWeight = formProvider.lWeight!;
          lCOlor = formProvider.lColor!;
          clicked = false;
        });
      });
    }
  }
}
