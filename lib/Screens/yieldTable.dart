import 'package:flutter/material.dart';
import 'package:lettus/Screens/yieldGraph.dart';
import 'package:provider/provider.dart';

import 'package:lettus/Providers/provider.dart';
import 'package:lettus/Screens/dashboard.dart';
import 'package:lettus/Screens/pedictionPage.dart';
import 'package:lettus/Services/predictService.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/customGraph.dart';
import 'package:lettus/Widgets/dashboardTopCard.dart';
import 'package:lettus/Widgets/loading.dart';

class YieldTable extends StatefulWidget {
  const YieldTable({super.key});

  @override
  State<YieldTable> createState() => _YieldTableState();
}

class _YieldTableState extends State<YieldTable> {
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
        NavigationUtils.backNavigation(context, YieldGraph());
      },
      child: Stack(
        children: [
          Scaffold(
            body: Column(
              children: [
                DashboardTopCard(
                    title: "Yield Records",
                    t1: "Analyzing the graph, you can understand",
                    t2: " the impact of the following",
                    t3: "parameters on yield",
                    onTap: () {
                      NavigationUtils.backNavigation(context, YieldGraph());
                    },
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Temperature')),
                                DataColumn(label: Text('Light')),
                                DataColumn(label: Text('EC')),
                                DataColumn(label: Text('pH')),
                                DataColumn(label: Text('Yield')),
                              ],
                              rows: formProvider.fetchedTableRecords.map((record) {
                                return DataRow(cells: [
                                  DataCell(Text(record['Temp'].toString())),
                                  DataCell(Text(record['Light'].toString())),
                                  DataCell(Text(record['MediaEC'].toString())),
                                  DataCell(Text(record['Water'].toString())),
                                  DataCell(Text(record['Yield'].toString())),
                                ]);
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
      await predictService.fetchData(context).then((value) {
        setState(() {
          clicked = false;
        });
      });
    }
  }
}

