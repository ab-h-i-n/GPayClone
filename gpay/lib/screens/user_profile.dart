import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpay/providers/auth_provider.dart';
import 'package:gpay/widgets/back_more_header.dart';
import "../constants/app_colors.dart";
import "../constants/app_logos.dart";

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
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
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user?.name ?? "XXXXXXXXXX",
                                style: TextStyle(
                                  color: AppColors.textColorMain,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'UPI ID : ${user?.email ?? "XXXXXXXXXX"}',
                                style: TextStyle(
                                  color: AppColors.textColorMain,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                user?.phone ?? "XXXXXXXXXX",
                                style: TextStyle(
                                  color: AppColors.textColorMain,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          )
                        ],
                      ),

                      //signout button
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pushNamed('/');
                          ref.read(authProvider.notifier).signOut();
                          ref.invalidate(authProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color: AppColors.textColorMain,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
