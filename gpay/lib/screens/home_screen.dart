import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpay/widgets/manage_your_money_section.dart';
import 'package:gpay/widgets/peoples_section.dart';
import 'package:gpay/widgets/services_container.dart';
import 'package:gpay/widgets/bills_recharges_section.dart';
import '../constants/app_colors.dart';
import '../constants/app_logos.dart';
import '../widgets/tags_section.dart';
import '../widgets/offers_rewards_section.dart';
import '../widgets/invite_friends_section.dart';
import "../providers/auth_provider.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // header with banner
                Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.serachBarColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 12,
                                ),
                                child: Row(
                                  spacing: 10,
                                  children: [
                                    Icon(Icons.search,
                                        color: AppColors.textColorMain),
                                    Text(
                                      'Search',
                                      style: TextStyle(
                                          color: AppColors.secondary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: user?.photoUrl != null
                                    ? NetworkImage(
                                        user?.photoUrl as String,
                                      )
                                    : AssetImage(AppLogos.noUser),
                              ),
                            )
                          ],
                        ),
                      ),

                      // banner
                      Image(
                        image: AssetImage(AppLogos.homeBanner),
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 10,
                    children: [
                      // services
                      ServicesContainer(),
                      // tags
                      TagsSection(),
                      //peoples
                      PeoplesSection(),

                      // bills & recharges
                      BillsRechargesSection(),

                      // offers & rewards
                      OffersRewardsSection(),

                      //manage your money
                      ManageYourMoneySection(),
                    ],
                  ),
                ),

                // invite friends
                InviteFriendsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
