import 'package:flutter/material.dart';
import "../constants/app_colors.dart";
import "package:google_fonts/google_fonts.dart";

class ManageYourMoneySection extends StatelessWidget {
  ManageYourMoneySection({super.key});

  final List<Map<String, dynamic>> manageMoneyItems = [
    {'icon': Icons.speed_outlined, 'title': 'Check your CIBIL score for free'},
    {'icon': Icons.history, 'title': 'See transaction history'},
    {'icon': Icons.account_balance_outlined, 'title': 'Check bank balance'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manage your money',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorMain,
            ),
          ),
          SizedBox(height: 16),
          ...manageMoneyItems.map(
            (e) => ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                foregroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  spacing: 14,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      e['icon'],
                      color: AppColors.tertiary,
                      size: 26,
                    ),
                    Expanded(
                        child: Text(
                      e['title'],
                      style: GoogleFonts.inter(
                          color: AppColors.textColorMain,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
