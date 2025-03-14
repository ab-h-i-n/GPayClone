import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "../constants/app_colors.dart";
import "../constants/app_logos.dart";
import '../providers/phone_provider.dart';


class LoginInput extends ConsumerStatefulWidget {
  const LoginInput({super.key});

  @override
  ConsumerState<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends ConsumerState<LoginInput> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedPhoneNumber();
    phoneController.text = ref.read(phoneProvider);
    phoneController.addListener(_formatPhoneNumber);
  }

  @override
  void dispose() {
    phoneController.removeListener(_formatPhoneNumber);
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPhoneNumber = prefs.getString('phoneNumber') ?? '';
    if (savedPhoneNumber.isNotEmpty) {
      phoneController.text = savedPhoneNumber;
      ref.read(phoneProvider.notifier).state = savedPhoneNumber;
    }
  }

  void _formatPhoneNumber() {
    String text = phoneController.text.replaceAll(' ', '');
    if (text.length > 10) {
      text = text.substring(0, 10);
    }
    if (text.length > 5) {
      text = '${text.substring(0, 5)} ${text.substring(5)}';
    }

    ref.read(phoneProvider.notifier).state = text.replaceAll(' ', '');

    phoneController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: double.infinity),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.secondary),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage(AppLogos.indiaFlag), height: 25),
            const SizedBox(width: 20),
            Text(
              '+91',
              style: TextStyle(
                color: AppColors.textColorMain,
                fontSize: 25,
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: 206,
              child: TextField(
                controller: phoneController,
                onChanged: (String value) {
                  _formatPhoneNumber();
                },
                keyboardType: TextInputType.number,
                maxLength: 13, // 10 digits + 1 space
                style: TextStyle(
                  fontFamily: GoogleFonts.rubik().fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColorMain,
                ),
                cursorColor: AppColors.tertiary,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '00000 00000',
                  counterText: "", // Hide counter
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.rubik().fontFamily,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
