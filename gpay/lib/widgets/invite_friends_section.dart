import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_logos.dart';
import '../constants/app_colors.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendsSection extends StatelessWidget {
  const InviteFriendsSection({super.key});

  String getRandomReferralCode() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = chars.split('')..shuffle();
    return random.take(7).join();
  }

  @override
  Widget build(BuildContext context) {
    final code = getRandomReferralCode();

    void shareText() {
      Share.share(
          'Get ₹21 cashback on your first Google Pay payment. Use the code $code before you pay. Download now: https://g.co/payinvite/$code. #IndiaPaysDigitally');
    }

    return Stack(
      children: [
        Image(
          image: AssetImage(
            AppLogos.inviteBanner,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 55,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite friends to get ₹201',
                  style: TextStyle(
                      color: AppColors.textColorMain,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                SizedBox(height: 10),
                Text(
                  'Invite friends to Google Pay and get ₹201 when your\nfriend sends their first payment. They get ₹21!',
                  style: TextStyle(
                    color: const Color.fromARGB(200, 227, 227, 227),
                    fontSize: 13.3,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Copy your code',
                      style: TextStyle(
                        color: const Color.fromARGB(200, 227, 227, 227),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      code,
                      style: TextStyle(
                        color: AppColors.textColorMain,
                        fontSize: 13.3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      splashRadius: 40,
                      splashColor: AppColors.textColorMain,
                      color: AppColors.textColorMain,
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
                        minimumSize: WidgetStatePropertyAll(Size(0, 0)),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: code));
                        SnackBar(content: Text('Copied to clipboard'));
                      },
                      icon: Icon(
                        Icons.copy,
                        color: AppColors.textColorMain,
                        size: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    shareText();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    overlayColor: AppColors.secondary,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Invite',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.tertiary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
