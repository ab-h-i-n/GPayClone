import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/widgets/back_more_header.dart';
import '../constants/app_logos.dart';
import '../providers/phone_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class BankVerificationLoading extends ConsumerStatefulWidget {
  const BankVerificationLoading({super.key});

  @override
  ConsumerState<BankVerificationLoading> createState() =>
      _BankVerificationLoadingState();
}

class _BankVerificationLoadingState
    extends ConsumerState<BankVerificationLoading> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a loading process
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
      // Navigate to the home screen after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamedAndRemoveUntil(context, '/home-screen', (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var phone = ref.watch(phoneProvider);
    var formattedPhn =
        "+91 ${phone.substring(0, 5)} ${phone.substring(5, phone.length)}";

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: BackMoreHeader(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue.shade800),
                                strokeWidth: 8,
                              )
                            : null,
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(width: 5, color: AppColors.primary),
                            color: isLoading
                                ? const Color.fromARGB(255, 215, 230, 255)
                                : Colors.green,
                          ),
                          child: Icon(
                            isLoading ? Icons.phone_android_sharp : Icons.check,
                            color: isLoading ? Colors.blue : Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    isLoading
                        ? "Verifying $formattedPhn"
                        : "Verification Complete",
                    style: GoogleFonts.rubik(
                      color: AppColors.textColorMain,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image(
                image: AssetImage(AppLogos.vector2),
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
