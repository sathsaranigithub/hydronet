import 'package:flutter/material.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color buttonColor;
  final Color bordColor;
  final Color textColor;
  final double width;
  final double height;
  final double rad;
  final double dens;
  final double fontSize;
  final FontWeight fontWeight;
  final String fFamily;
  final bool show;

  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.buttonColor,
    required this.width,
    required this.fontSize,
    required this.fontWeight,
    this.rad = 20.0,
    this.dens = 1.0,
    this.textColor = AppColors.white1,
    this.height = 44.0,
    this.fFamily = AppFonts.openSans,
    this.bordColor = AppColors.green1,
    this.show = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(rad),
        border: Border.all(
          color: bordColor,
          width: dens,
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
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(rad),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: show,
              child: Icon(
                Icons.logout,
                color: textColor,
                size: 20.0,
              ),
            ),
            Visibility(
              visible: show,
              child: SizedBox(
                width: 10.0,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: fFamily,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
