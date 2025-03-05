import 'package:flutter/material.dart';
import 'package:lettus/Utils/appColors.dart';
import 'package:lettus/Utils/appfonts.dart';

class Popupmsgbox extends StatelessWidget {
  final bool show;
  final String t1;
  final String t2;
  final String t3;
  final VoidCallback onTap;
  final VoidCallback onTap1;

  const Popupmsgbox({
    Key? key,
    this.show = true,
    required this.t1,
    required this.t2,
    required this.t3,
    required this.onTap,
    required this.onTap1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.white2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onTap,
                ),
              ],
            ),
            Text(
              t1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: AppFonts.font24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green1,
                  fontFamily: AppFonts.lemonada),
            ),
            SizedBox(height: 33),
            Text(
              t2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: AppFonts.font22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black1,
                  fontFamily: AppFonts.poppins),
            ),
            Visibility(visible: show, child: SizedBox(height: 32)),
            Visibility(
              visible: show,
              child: Image.asset(
                'assets/boxlogo.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.22),
                ),
              ),
              onPressed: onTap1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Text(
                  t3,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontFamily: AppFonts.poppins),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
