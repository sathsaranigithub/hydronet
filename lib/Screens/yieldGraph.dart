import 'package:flutter/material.dart';
import 'package:lettus/Screens/yieldTable.dart';
import 'package:lettus/Widgets/predictTopCard.dart';
import 'package:provider/provider.dart';

import 'package:lettus/Providers/provider.dart';
import 'package:lettus/Screens/dashboard.dart';
import 'package:lettus/Screens/pedictionPage.dart';
import 'package:lettus/Services/predictService.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/customGraph.dart';
import 'package:lettus/Widgets/dashboardTopCard.dart';
import 'package:lettus/Widgets/loading.dart';

class YieldGraph extends StatefulWidget {
  const YieldGraph({super.key});

  @override
  State<YieldGraph> createState() => _YieldGraphState();
}

class _YieldGraphState extends State<YieldGraph> {
  bool clicked = false;

  @override
  void initState() {
    super.initState();
    initProcess();
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<MyModel>(context, listen: false);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        NavigationUtils.backNavigation(context, PedictionPage());
      },
      child: Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  PredictTopCard(
                    name: "Yield Table",
                    onBtnTap: () {
                      NavigationUtils.frontNavigation(context, YieldTable());
                    },
                    onTap: () {
                      NavigationUtils.backNavigation(context, Dashboard());
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomGraph(
                            ordinalList: formProvider.ordinalList,
                            title: 'Impact of Light Intensity on Yield',
                            maxValue: 30,
                            symbol: 'L',
                            mean: 'Light Intensity',
                          ),
                          CustomGraph(
                            title: 'Impact of media EC on Yield',
                            maxValue: 6,
                            symbol: 'M',
                            mean: 'Media Electrical Conductivity',
                            ordinalList: formProvider.ordinalList2,
                          ),
                          CustomGraph(
                            title: 'Impact of Water PH on Yield',
                            maxValue: 10,
                            symbol: 'W',
                            mean: 'Water PH',
                            ordinalList: formProvider.ordinalList3,
                          ),
                          CustomGraph(
                            title: 'Impact of Ambient temperature on Yield',
                            maxValue: 40,
                            symbol: 'T',
                            mean: 'Ambient temperature',
                            ordinalList: formProvider.ordinalList4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (clicked) const Loading(),
        ],
      ),
    );
  }

  Future<void> initProcess() async {
    if (!clicked) {
      setState(() {
        clicked = true;
      });

      PredictService predictService = PredictService();
      await predictService.fetchMediaData(context);
      await predictService.fetchWaterData(context);
      await predictService.fetchTemperatureData(context);
      await predictService.fetchLightData(context).then((value) {
        setState(() {
          clicked = false;
        });
      });
    }
  }
}
