import 'package:flutter/material.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';
import 'package:lettus/Widgets/label.dart';

class DashboardCard extends StatelessWidget {
  final String labelText;
  final String imagePath;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.labelText,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: (MediaQuery.of(context).size.height * 31) / 913,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Label(
            hintText: labelText,
            textColor: AppColors.black1,
            fontSize: AppFonts.font18,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            width: double.infinity,
            height: (MediaQuery.of(context).size.height * 210) / 901,
          ),
        ),
      ],
    );
  }
}
