import 'package:flutter/material.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final double hit;

  final Color borderColor;
  final bool obscureText;
  final Color col1;
  final Color hintCol1;
  final bool edits;

  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.edits = true,
      this.borderColor = AppColors.gray1,
      this.hintCol1 = AppColors.black1,
      this.col1 = AppColors.white1,
      this.obscureText = false,
      this.hit = 43.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hit,
      decoration: BoxDecoration(
        color: col1,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: TextFormField(
          obscureText: obscureText,
          enabled: edits,
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: hintCol1,
                fontWeight: FontWeight.normal,
                fontFamily: AppFonts.poppins,
                fontSize: AppFonts.font15),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 9.5, horizontal: 16.0),
            isDense: true,
          ),
        ),
      ),
    );
  }
}
