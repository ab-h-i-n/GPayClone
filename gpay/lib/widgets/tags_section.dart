import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class TagsSection extends StatelessWidget {
  const TagsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          dashPattern: [5, 5],
          color: const Color.fromARGB(132, 126, 129, 127),
          strokeWidth: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 4,
            ),
            child: Row(
              children: [
                Center(
                  child: Text(
                    "Activate UPI Lite ",
                    style: TextStyle(
                        color: AppColors.textColorMain,
                        fontSize: 11,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(
                  Icons.add_circle_outline,
                  color: AppColors.textColorMain,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.serachBarColor,
          ),
          child: Text(
            "UPI ID : ${user?.email?.split('@')[0]}@oksbi",
            style: GoogleFonts.inter(
                color: AppColors.textColorMain,
                fontSize: 11,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
