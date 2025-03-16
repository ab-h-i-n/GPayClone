import 'package:flutter/material.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BillsRechargesSection extends StatelessWidget {
  BillsRechargesSection({super.key});

  final List<Map<String, dynamic>> billsRecharges = [
    {
      'icon': Icons.charging_station_outlined,
      'title': 'Mobile \n recharge',
    },
    {
      'icon': Icons.tv_sharp,
      'title': 'DTH / Cable \n TV',
    },
    {
      'icon': Icons.emoji_objects_outlined,
      'title': 'Electricity',
    },
    {'icon': Icons.minor_crash_outlined, 'title': 'FASTag \n recharge'}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bills & Recharges',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textColorMain,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'No bills due',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...billsRecharges.map((e) => Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color(0xFF004A77),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            e['icon'],
                            size: 24,
                            color: AppColors.tertiary,
                          ),
                        ),
                        Text(
                          e['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textColorMain,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColors.secondary,
                    ),
                  ),
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.tertiary,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
