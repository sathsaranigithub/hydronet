import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lettus/Screens/yieldGraph.dart';
import 'package:provider/provider.dart';

import 'package:lettus/Providers/provider.dart';
import 'package:lettus/Screens/dashboard.dart';
import 'package:lettus/Services/predictService.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Utils/constValues.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/button.dart';
import 'package:lettus/Widgets/labelResponsive.dart';
import 'package:lettus/Widgets/loading.dart';
import 'package:lettus/Widgets/myTextField.dart';
import 'package:lettus/Widgets/predictTopCard.dart';
import 'package:lettus/Widgets/snackBar.dart';

class PedictionPage extends StatefulWidget {
  const PedictionPage({super.key});

  @override
  State<PedictionPage> createState() => _PedictionPageState();
}

class _PedictionPageState extends State<PedictionPage> {
  bool isLoading = false;
  final lightController = TextEditingController();
  final temperatureController = TextEditingController();
  final waterController = TextEditingController();
  final mediaController = TextEditingController();
  late User userem;

  @override
  void dispose() {
    lightController.dispose();
    temperatureController.dispose();
    waterController.dispose();
    mediaController.dispose();

    super.dispose();
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

        NavigationUtils.backNavigation(context, Dashboard());
      },
      child: Stack(children: [
        Scaffold(
          backgroundColor: AppColors.white1,
          body: Column(
            children: [
              Container(
                color: AppColors.green1,
                child: Column(
                  children: [
                    PredictTopCard(
                      name: "Yield Graph",
                      onBtnTap: () {
                        NavigationUtils.frontNavigation(context, YieldGraph());
                      },
                      onTap: () {
                        NavigationUtils.backNavigation(context, Dashboard());
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 2.0, top: 10.0),
                              child: LabelResponsive(
                                  hintText:
                                      "How much does light intensity affect the growth and yield of lettuce?",
                                  textColor: AppColors.black1,
                                  fontSize: AppFonts.font16,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyTextField(
                                keyboardType: TextInputType.number,
                                hintCol1: AppColors.green2,
                                hit: 48.0,
                                controller: lightController,
                                hintText: "e.g. 23996.23",
                                borderColor: AppColors.gray1,
                                col1: AppColors.white1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 2.0, top: 10.0),
                              child: LabelResponsive(
                                  hintText:
                                      "How much is the ideal ambient temperature range for lettuce growth?",
                                  textColor: AppColors.black1,
                                  fontSize: AppFonts.font16,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyTextField(
                                hit: 48.0,
                                keyboardType: TextInputType.number,
                                controller: temperatureController,
                                hintText: "e.g. 28.94",
                                hintCol1: AppColors.green2,
                                borderColor: AppColors.gray1,
                                col1: AppColors.white1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 2.0, top: 10.0),
                              child: LabelResponsive(
                                  hintText:
                                      "How much does water pH influence nutrient absorption in lettuce plants?",
                                  textColor: AppColors.black1,
                                  fontSize: AppFonts.font16,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyTextField(
                                keyboardType: TextInputType.number,
                                hit: 48.0,
                                controller: waterController,
                                hintText: "e.g. 6.32",
                                hintCol1: AppColors.green2,
                                borderColor: AppColors.gray1,
                                col1: AppColors.white1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 2.0, top: 10.0),
                              child: LabelResponsive(
                                  hintText:
                                      "How much does media EC (Electrical Conductivity) affect the availability of nutrients to lettuce plants?",
                                  textColor: AppColors.black1,
                                  fontSize: AppFonts.font16,
                                  fontFamily: AppFonts.poppins,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyTextField(
                                keyboardType: TextInputType.number,
                                hit: 48.0,
                                controller: mediaController,
                                hintText: "e.g. 1.29",
                                hintCol1: AppColors.green2,
                                borderColor: AppColors.gray1,
                                col1: AppColors.white1,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Button(
                                    rad: 5.0,
                                    onPressed: () {
                                      autoFillLogic(context);
                                    },
                                    text: "Auto Fill",
                                    buttonColor: AppColors.green1,
                                    width: double.infinity,
                                    fontSize: AppFonts.font20,
                                    fontWeight: FontWeight.w500)),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Button(
                                    rad: 5.0,
                                    onPressed: () {
                                      buttonLogic(context);
                                    },
                                    text: "Predict Yield",
                                    buttonColor: AppColors.green1,
                                    width: double.infinity,
                                    fontSize: AppFonts.font20,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isLoading) const Loading(),
      ]),
    );
  }

  void autoFillLogic(BuildContext context) {
    if (isLoading == false) {
      setState(() {
        isLoading = true;
      });
      final formProvider = Provider.of<MyModel>(context, listen: false);

      PredictService predictService = PredictService();
      predictService.fetchIotData(context).then((value) {
        setState(() {
          mediaController.text = formProvider.media.toString();
          waterController.text = formProvider.water.toString();
          temperatureController.text =
              formProvider.temperature.toInt().toString();
          lightController.text = formProvider.light.toInt().toString();
          isLoading = false;
        });
      });
    }
  }

  void buttonLogic(BuildContext context) {
    if (lightController.text.isNotEmpty &&
        temperatureController.text.isNotEmpty &&
        waterController.text.isNotEmpty &&
        mediaController.text.isNotEmpty) {
      if (double.tryParse(lightController.text)! <= 30000 &&
          double.tryParse(lightController.text)! >= 20000) {
        if (double.tryParse(temperatureController.text)! <= 33 &&
            double.tryParse(temperatureController.text)! >= 20) {
          if (double.tryParse(waterController.text)! <= 6.5 &&
              double.tryParse(waterController.text)! >= 6.0) {
            if (double.tryParse(mediaController.text)! <= 2.5 &&
                double.tryParse(mediaController.text)! >= 0.8) {
              if (isLoading == false) {
                setState(() {
                  isLoading = true;
                });
                final formProvider =
                    Provider.of<MyModel>(context, listen: false);

                formProvider.updateLight(double.parse(lightController.text));
                formProvider.updateTemperature(
                    double.parse(temperatureController.text));
                formProvider.updateWater(double.parse(waterController.text));
                formProvider.updateMedia(double.parse(mediaController.text));

                PredictService predictService = PredictService();
                predictService.getPrediction(context).then((value) {
                  setState(() {
                    isLoading = false;
                  });
                });
              }
            } else {
              SnackbarUtils.showDefaultSnackBar(
                  context,
                  "Media EC value should be in-between 0.8 & 2.5",
                  AppColors.errorcolor);
            }
          } else {
            SnackbarUtils.showDefaultSnackBar(
                context,
                "Water pH value should be in-between 6.0 & 6.5",
                AppColors.errorcolor);
          }
        } else {
          SnackbarUtils.showDefaultSnackBar(
              context,
              "Ambient Temperature value should be in-between 20 & 33",
              AppColors.errorcolor);
        }
      } else {
        SnackbarUtils.showDefaultSnackBar(
            context,
            "Light Intensity value should be in-between 20000 & 30000",
            AppColors.errorcolor);
      }
    } else {
      SnackbarUtils.showDefaultSnackBar(
          context, ConstValues.allRequiredMsg, AppColors.errorcolor);
    }
  }
}
