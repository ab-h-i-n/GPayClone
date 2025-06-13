import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/widgets/back_more_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BankBalanceScreen extends StatelessWidget {
  const BankBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackMoreHeader(),
              const SizedBox(height: 20),
              Text(
                'Bank Balance',
                style: GoogleFonts.inter(
                  color: AppColors.textColorMain,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: 175,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 32, 32),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            '₹0.00',
                            style: GoogleFonts.inter(
                              color: AppColors.textColorMain,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return Text(
                            '₹0.00',
                            style: GoogleFonts.inter(
                              color: AppColors.textColorMain,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return Text(
                            '₹0.00',
                            style: GoogleFonts.inter(
                              color: AppColors.textColorMain,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        final data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final amount = data['amount'] ?? 0;
                        final formatter = NumberFormat.currency(
                          locale: 'en_IN',
                          symbol: '₹',
                          decimalDigits: 2,
                        );

                        return Text(
                          formatter.format(amount),
                          style: GoogleFonts.inter(
                            color: AppColors.textColorMain,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'State Bank of India .......0064',
                              style: TextStyle(
                                color: AppColors.textColorMain,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Savings account',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 189, 189, 189),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/sbi_logo.png',
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                              color: const Color.fromARGB(255, 46, 171, 255),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
