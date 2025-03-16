import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_logos.dart';
import 'package:google_fonts/google_fonts.dart';

class OffersRewardsSection extends StatelessWidget {
  OffersRewardsSection({super.key});

  final List<Map<String, dynamic>> offerNrewards = [
    {"image": AppLogos.rewardsIcon, "title": "Rewards"},
    {"image": AppLogos.offersIcon, "title": "Offers"},
    {"image": AppLogos.referralsIcon, "title": "Referrals"},
    {"image": AppLogos.tezShotsIcon, "title": "Tez Shots"}
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
            'Offers & Rewards',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textColorMain,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...offerNrewards.map((e) => Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.serachBarColor,
                          shape: BoxShape.circle,
                        ),
                        child: Image(
                          image: AssetImage(
                            e['image'],
                          ),
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
        ],
      ),
    );
  }
}
