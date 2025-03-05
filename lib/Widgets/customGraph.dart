import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Widgets/label.dart';

class CustomGraph extends StatelessWidget {
  final List<FlSpot> ordinalList;
  final String title;
  final int maxValue;
  final String symbol;
  final String mean;

  CustomGraph({
    Key? key,
    required this.ordinalList,
    required this.title,
    required this.maxValue,
    required this.symbol,
    required this.mean,
  }) : super(key: key);

  @override
  final List<FlSpot> data = [
    FlSpot(10, 100), // (Yield, Light Intensity)
    FlSpot(20, 150),
    FlSpot(30, 200),
    FlSpot(40, 250),
    FlSpot(50, 300),
  ];
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.green4,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.green4,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Label(
                      hintText: title,
                      textColor: AppColors.black1,
                      fontSize: AppFonts.font18,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 180,
              color: AppColors.green4,
              child: ordinalList.isEmpty
                  ? const Center(child: Text('No data available'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: LineChart(
                            LineChartData(
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true, reservedSize: 40),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true, reservedSize: 40),
                                ),
                              ),
                              borderData: FlBorderData(show: true),
                              gridData: FlGridData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: ordinalList,
                                  isCurved: false,
                                  barWidth: 4,
                                  belowBarData: BarAreaData(show: false),
                                  dotData: FlDotData(show: true),
                                  color: AppColors.blue1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.green4,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Label(
                      hintText: "$symbol = $mean",
                      textColor: AppColors.black1,
                      fontSize: AppFonts.font15,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
                    ),
                    Label(
                      hintText: "Y = Yield",
                      textColor: AppColors.black1,
                      fontSize: AppFonts.font15,
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w500,
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
