import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpay/constants/app_colors.dart';
import 'package:gpay/constants/app_logos.dart';
import 'package:gpay/widgets/dropdown_button.dart';
import 'package:gpay/widgets/login_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/phone_provider.dart';

class InitialScreen extends ConsumerWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phoneNumber = ref.watch(phoneProvider);
    bool isPhoneNumberValid = phoneNumber.length == 10;

    print(phoneNumber);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 10,
                      children: [
                        CustomDropdownButton(
                          text: 'English',
                          icon: Icons.language,
                          iconSize: 20,
                          iconColor: AppColors.tertiary,
                        ),
                        CustomDropdownButton(
                          text: 'IN',
                          icon: AppLogos.indiaFlag,
                          iconSize: 30,
                          verticalPadding: 3,
                        ),
                        SizedBox(
                          child:
                              Icon(Icons.more_vert, color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Image(
                      image: AssetImage(AppLogos.googlePay), height: 50),
                  const SizedBox(height: 24),
                  const Text(
                    'Welcome to Google Pay',
                    style: TextStyle(
                      color: AppColors.textColorMain,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Enter your phone number',
                    style: GoogleFonts.inter(
                      color: AppColors.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const LoginInput(),
                ],
              ),
            ),
            Positioned(
              bottom: !isPhoneNumberValid ? 0 : 10,
              left: MediaQuery.of(context).size.width * 0.05,
              child: !isPhoneNumberValid
                  ? Image(
                      image: AssetImage(AppLogos.vector1),
                      width: MediaQuery.of(context).size.width * 0.9,
                      fit: BoxFit.cover,
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tertiary,
                        minimumSize:
                            Size(MediaQuery.of(context).size.width * 0.9, 40),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
