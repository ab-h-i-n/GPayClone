import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/widgets/back_more_header.dart';
import '../constants/app_logos.dart';
import '../providers/phone_provider.dart';

class BankVerificationLoading extends ConsumerWidget {
  const BankVerificationLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var phone = ref.watch(phoneProvider);
    var formattedPhn = "+91 " + phone.substring(0, 5) + " " + phone.substring(5, phone.length);

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
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.tertiary),
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Verifying $formattedPhn",
                    style: TextStyle(
                      color: AppColors.textColorMain,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
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