import 'package:flutter/material.dart';
import 'package:lettus/Screens/yieldGraph.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Utils/pageNavigations.dart';
import 'package:lettus/Widgets/button.dart';
import 'package:lettus/Widgets/labelResponsive.dart';

class PredictTopCard extends StatefulWidget {
  final VoidCallback? onTap;
  final VoidCallback onBtnTap;
  final String name;
  const PredictTopCard({
    Key? key,
    this.onTap,
    required this.onBtnTap,
    required this.name,
  }) : super(key: key);

  @override
  State<PredictTopCard> createState() => _PredictTopCardState();
}

class _PredictTopCardState extends State<PredictTopCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.green1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    width: (MediaQuery.of(context).size.width * 40) / 430,
                    child: IconButton(
                      color: AppColors.white1,
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 25.0,
                      onPressed: widget.onTap,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width -
                ((MediaQuery.of(context).size.width * 40) / 430)),
            child: Column(
              children: [
                LabelResponsive(
                    isItalic: true,
                    hintText: "Lettuce Yield Prediction",
                    textColor: AppColors.white1,
                    fontSize: AppFonts.font24,
                    fontFamily: "lemonadasemibold",
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
          SizedBox(
            height: ((MediaQuery.of(context).size.height * 17) / 901),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: ((MediaQuery.of(context).size.width * 269) / 430),
                  child: LabelResponsive(
                      isItalic: true,
                      hintText:
                          "We predict lettuce crop yields to improve agricultural efficiency.",
                      textColor: AppColors.white1,
                      fontSize: AppFonts.font14,
                      fontFamily: "lemonadasemibold",
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/boxlogo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, bottom: 18.0),
            child: Row(
              children: [
                Button(
                    onPressed: widget.onBtnTap,
                    text: widget.name,
                    buttonColor: AppColors.green3,
                    width: (MediaQuery.of(context).size.width * 194) / 430,
                    fontSize: AppFonts.font20,
                    fontWeight: FontWeight.w500),
              ],
            ),
          )
        ],
      ),
    );
  }
}
