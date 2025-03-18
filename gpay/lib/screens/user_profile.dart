import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpay/providers/auth_provider.dart';
import 'package:gpay/widgets/back_more_header.dart';
import 'package:gpay/widgets/option_button.dart';
import "../constants/app_colors.dart";
import "../constants/app_logos.dart";

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  static List options = [
    {
      'icon': Icons.credit_card,
      'title': 'Pay with credit or debit cards',
      'subtitle': 'Bills, online shopping, and more',
      'action' : 'Add'
    },
    {
      'icon': Icons.qr_code_2_rounded,
      'title': 'Your QR code',
      'subtitle': 'Use to receive money from any UPI app',
    },
    {
      'icon': Icons.autorenew_sharp,
      'title': 'Autopay',
      'subtitle': 'No pending requests',
    },
    {
      'icon': Icons.settings_outlined,
      'title': 'Settings',
    },
    {
      'icon': Icons.account_circle,
      'title': 'Manage Google account',
    },
    {
      'icon': Icons.help_outline_rounded,
      'title': 'Get help',
    },
    {
      'icon': Icons.language_rounded,
      'title': 'Language',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage(
                  AppLogos.profileBanner,
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      BackMoreHeader(),
                      SizedBox(
                        height: 33,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? "XXXXXXXXXX",
                                  style: TextStyle(
                                    color: AppColors.textColorMain,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'UPI ID : ${user?.email.split('@')[0] ?? "XXXXXXXXXX"}@oksbi',
                                  style: TextStyle(
                                    color: AppColors.textColorMain,
                                    fontSize: 15,
                                  ),
                                ),
                                Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      user?.phone ?? "XXXXXXXXXX",
                                      style: TextStyle(
                                        color: AppColors.textColorMain,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0842A0),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        spacing: 5,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: AppColors.tertiary,
                                            size: 15,
                                          ),
                                          Text(
                                            'UPI number',
                                            style: TextStyle(
                                              color: AppColors.tertiary,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: user?.photoUrl != null
                                      ? NetworkImage(user?.photoUrl as String)
                                      : AssetImage(AppLogos.noUser)
                                          as ImageProvider,
                                ),
                                Positioned(
                                  bottom: -4,
                                  right: -4,
                                  child: Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 52, 52, 57),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: AppColors.serachBarColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.qr_code_2,
                                      color: AppColors.textColorMain,
                                      size: 25,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: options
                  .map(
                    (item) => OptionButton(
                      icon: item['icon'],
                      title: item['title'],
                      subtitle:
                          item.containsKey('subtitle') ? item['subtitle'] : '',
                      action : item.containsKey('action') ? item['action'] : '',
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
