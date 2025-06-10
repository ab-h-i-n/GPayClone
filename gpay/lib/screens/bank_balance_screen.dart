import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/widgets/back_more_header.dart';
import 'package:google_fonts/google_fonts.dart';

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
              const SizedBox(height: 40),
              Text(
                'Available Balance',
                style: GoogleFonts.inter(
                  color: AppColors.textColorMain,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Text('No balance data available');
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final amount = data['amount'] ?? 0;

                  return Text(
                    '₹${amount.toString()}',
                    style: GoogleFonts.inter(
                      color: AppColors.textColorMain,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
