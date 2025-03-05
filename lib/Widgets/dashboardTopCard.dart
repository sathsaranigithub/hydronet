import 'package:flutter/material.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Widgets/label.dart';

class DashboardTopCard extends StatefulWidget {
  final VoidCallback? onTap;
  final String title;
  final String t1;
  final String t2;
  final String t3;
  const DashboardTopCard({
    Key? key,
    this.onTap,
    this.title = "HydroNet     ",
    this.t1 = "Empowering  farmers with cutting-edge",
    this.t2 = "AI technology for healthier crops and",
    this.t3 = "better yields",
  }) : super(key: key);

  @override
  State<DashboardTopCard> createState() => _DashboardTopCardState();
}

class _DashboardTopCardState extends State<DashboardTopCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.green1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 57.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width * 40) / 430,
                  child: IconButton(
                    color: AppColors.white1,
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 25.0,
                    onPressed: widget.onTap,
                  ),
                ),
                Container(
                  width: (MediaQuery.of(context).size.width -
                      ((MediaQuery.of(context).size.width * 40) / 430)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Label(
                          isItalic: true,
                          hintText: widget.title,
                          textColor: AppColors.white1,
                          fontSize: AppFonts.font24,
                          fontFamily: "lemonadasemibold",
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Label(
                  isItalic: true,
                  hintText: widget.t1,
                  textColor: AppColors.white1,
                  fontSize: AppFonts.font14,
                  fontFamily: "lemonadasemibold",
                  fontWeight: FontWeight.w500),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Label(
                    isItalic: true,
                    hintText: widget.t2,
                    textColor: AppColors.white1,
                    fontSize: AppFonts.font14,
                    fontFamily: "lemonadasemibold",
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Label(
                    isItalic: true,
                    hintText: widget.t3,
                    textColor: AppColors.white1,
                    fontSize: AppFonts.font14,
                    fontFamily: "lemonadasemibold",
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
